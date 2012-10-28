#include "ra_sound.h"

extern VALUE eRubyAudioError;
ID id_size;
ID id_seek;
ID id_read;
ID id_write;
ID id_tell;

/*
 * Class <code>CSound</code> is a very light wrapper around the
 * <code>SNDFILE</code> struct exposed by libsndfile.
 */
void Init_ra_sound() {
    VALUE mRubyAudio = rb_define_module("RubyAudio");
    VALUE cRASound = rb_define_class_under(mRubyAudio, "CSound", rb_cObject);
    rb_define_alloc_func(cRASound, ra_sound_allocate);
    rb_define_singleton_method(cRASound, "open", ra_sound_s_open, -1);
    rb_define_method(cRASound, "initialize", ra_sound_init, 3);
    rb_define_method(cRASound, "info", ra_sound_info, 0);
    rb_define_method(cRASound, "seek", ra_sound_seek, 2);
    rb_define_method(cRASound, "read", ra_sound_read, 2);
    rb_define_method(cRASound, "write", ra_sound_write, 1);
    rb_define_method(cRASound, "<<", ra_sound_addbuf, 1);
    rb_define_method(cRASound, "close", ra_sound_close, 0);
    rb_define_method(cRASound, "closed?", ra_sound_closed, 0);

    // Get refs to commonly used symbols and ids
    id_size = rb_intern("size");
    id_seek = rb_intern("seek");
    id_read = rb_intern("read");
    id_write = rb_intern("write");
    id_tell = rb_intern("tell");
}

static VALUE ra_sound_allocate(VALUE klass) {
    RA_SOUND *snd = ALLOC(RA_SOUND);
    memset(snd, 0, sizeof(RA_SOUND));
    VALUE self = Data_Wrap_Struct(klass, ra_sound_mark, ra_sound_free, snd);
    return self;
}

static void ra_sound_mark(RA_SOUND *snd) {
    if(snd) {
        rb_gc_mark(snd->info);
        if(snd->vio_source) rb_gc_mark(snd->vio_source);
    }
}

static void ra_sound_free(RA_SOUND *snd) {
    if(!snd->closed && snd->snd != NULL) sf_close(snd->snd);
    xfree(snd);
}

/*
 * call-seq:
 *   CSound.open(...)                => snd
 *   CSound.open(...) {|snd| block } => obj
 *
 * With no associated block, <code>open</code> is a synonym for
 * <code>CSound.new</code>. If the optional code block is given, it will be
 * passed <i>snd</i> as an argument, and the CSound object will automatically be
 * closed when the block terminates. In this instance, <code>CSound.open</code>
 * returns the value of the block.
 */
static VALUE ra_sound_s_open(int argc, VALUE *argv, VALUE klass) {
    VALUE obj = rb_class_new_instance(argc, argv, klass);
    if(!rb_block_given_p()) return obj;
    return rb_ensure(rb_yield, obj, ra_sound_close_safe, obj);
}

static sf_count_t ra_vir_size(void *user_data) {
    VALUE io = (VALUE)user_data;
    return NUM2OFFT(rb_funcall(io, id_size, 0));
}

static sf_count_t ra_vir_seek(sf_count_t offset, int whence, void *user_data) {
    VALUE io = (VALUE)user_data;
    rb_funcall(io, id_seek, 2, OFFT2NUM(offset), INT2FIX(whence));
    return NUM2OFFT(rb_funcall(io, id_tell, 0));
}

static sf_count_t ra_vir_read(void *ptr, sf_count_t count, void *user_data) {
    VALUE io = (VALUE)user_data;
    if(count <= 0) return 0;

    // It would be nice if we could create a fake buffer string with ptr as the target
    VALUE read = rb_funcall(io, id_read, 1, OFFT2NUM(count));
    sf_count_t len = RSTRING_LEN(read);
    memcpy(ptr, RSTRING_PTR(read), RSTRING_LEN(read));
    return len;
}

static sf_count_t ra_vir_write(const void *ptr, sf_count_t count, void *user_data) {
    VALUE io = (VALUE)user_data;
    if(count <= 0) return 0;

    // It would be nice if we could create a fake string with ptr as the source
    VALUE str = rb_str_new(ptr, count);
    VALUE wrote = rb_funcall(io, id_write, 1, str);
    return NUM2OFFT(wrote);
}

static sf_count_t ra_vir_tell(void *user_data) {
    VALUE io = (VALUE)user_data;
    return NUM2OFFT(rb_funcall(io, id_tell, 0));
}

/*
 * call-seq:
 *   CSound.new(path, mode, info) => snd
 *   CSound.new(io, mode, info) => snd
 *
 * Returns a new <code>CSound</code> object for the audio file at the given path
 * or using the given fixed-length IO-like object with the given mode. Valid modes
 * are <code>"r"</code>, <code>"w"</code>, or <code>"rw"</code>.
 * <code>StringIO</code> is the only valid IO-like object in the standard library,
 * although any object that implements <code>size</code>, <code>seek</code>,
 * <code>read</code>, <code>write</code>, and <code>tell</code> will work.
 */
static VALUE ra_sound_init(VALUE self, VALUE source, VALUE mode, VALUE info) {
    RA_SOUND *snd;
    Data_Get_Struct(self, RA_SOUND, snd);

    // Get mode
    const char *m = StringValueCStr(mode);
    if(strcmp(m,      "rw") == 0) snd->mode = SFM_RDWR;
    else if(strcmp(m, "r") == 0)  snd->mode = SFM_READ;
    else if(strcmp(m, "w") == 0)  snd->mode = SFM_WRITE;
    else rb_raise(rb_eArgError, "invalid access mode %s", m);

    // Set info
    snd->info = info;

    // Open sound file
    SF_INFO *sf_info;
    Data_Get_Struct(info, SF_INFO, sf_info);
    if(TYPE(source) == T_STRING) {
        // Open sound file at the path
        const char *p = StringValueCStr(source);
        snd->snd = sf_open(p, snd->mode, sf_info);
    } else {
        // Check if the source implements the right methods
        if(!rb_respond_to(source, id_size)) rb_raise(eRubyAudioError, "source does not implement size");
        if(!rb_respond_to(source, id_seek)) rb_raise(eRubyAudioError, "source does not implement seek");
        if(!rb_respond_to(source, id_read)) rb_raise(eRubyAudioError, "source does not implement read");
        if(!rb_respond_to(source, id_write)) rb_raise(eRubyAudioError, "source does not implement write");
        if(!rb_respond_to(source, id_tell)) rb_raise(eRubyAudioError, "source does not implement tell");

        // Open sound using the virtual IO API
        snd->vio_source = source;
        SF_VIRTUAL_IO vir_io = {ra_vir_size, ra_vir_seek, ra_vir_read, ra_vir_write, ra_vir_tell};
        snd->snd = sf_open_virtual(&vir_io, snd->mode, sf_info, (void*)source);
    }
    if(snd->snd == NULL) rb_raise(eRubyAudioError, sf_strerror(snd->snd));
    snd->closed = 0;

    return self;
}

/*
 * call-seq:
 *   snd.info => CSoundInfo
 *
 * Returns the info object associated with the sound.
 */
static VALUE ra_sound_info(VALUE self) {
    RA_SOUND *snd;
    Data_Get_Struct(self, RA_SOUND, snd);
    return snd->info;
}

/*
 * call-seq:
 *   snd.seek(frames, whence) => 0
 *
 * Seeks to a given offset <i>anInteger</i> in the sound according to the value
 * of <i>whence</i>:
 *
 *   IO::SEEK_CUR  | Seeks to _frames_ plus current position
 *   --------------+----------------------------------------------------
 *   IO::SEEK_END  | Seeks to _frames_ plus end of stream (you probably
 *                 | want a negative value for _frames_)
 *   --------------+----------------------------------------------------
 *   IO::SEEK_SET  | Seeks to the absolute location given by _frames_
 */
static VALUE ra_sound_seek(VALUE self, VALUE frames, VALUE whence) {
    RA_SOUND *snd;
    Data_Get_Struct(self, RA_SOUND, snd);
    if(snd->closed) rb_raise(eRubyAudioError, "closed sound");

    if(sf_seek(snd->snd, (sf_count_t)NUM2OFFT(frames), FIX2INT(whence)) == -1) {
        rb_raise(eRubyAudioError, "invalid seek");
    }

    return INT2FIX(0);
}

#define DEFINE_RA_SOUND_READ_TYPE(itype) \
static void ra_sound_read_##itype(RA_SOUND *snd, RA_BUFFER *buf, sf_count_t frames) { \
    static itype temp[1024]; \
    int temp_len = 1024; \
    itype *data = (itype*)buf->data; \
    itype mix_sum; \
\
    /* Get info struct */ \
    SF_INFO *info; \
    Data_Get_Struct(snd->info, SF_INFO, info); \
\
    /* Up/Downmix based on channel matching */ \
    sf_count_t read = 0, r, amount; \
    int i, k; \
    if(buf->channels == info->channels) { /* Simply read data without mix */ \
        read = sf_readf_##itype(snd->snd, data, frames); \
    } else if(buf->channels == 1) { /* Downmix to mono */ \
        sf_count_t max = temp_len / info->channels; \
        int channels; \
\
        while(read < frames) { \
            /* Calculate # of frames to read */ \
            amount = frames - read; \
            if(amount > max) amount = max; \
\
            r = sf_readf_##itype(snd->snd, temp, amount); \
            if(r == 0) break; \
\
            /* Mix channels together by averaging all channels and store to buffer */ \
            for(i = 0; i < r; i++) { \
                mix_sum = 0; \
                for(k = 0; k < info->channels; k++) mix_sum += temp[i * info->channels + k]; \
                data[read] = mix_sum/info->channels; \
                read++; \
            } \
        } \
    } else if(info->channels == 1) { /* Upmix from mono by copying channel */ \
        while(read < frames) { \
            /* Calculate # of frames to read */ \
            amount = frames - read; \
            if(amount > temp_len) amount = temp_len; \
\
            r = sf_readf_##itype(snd->snd, temp, amount); \
            if(r == 0) break; \
\
            /* Write every frame channel times to the buffer */ \
            for(i = 0; i < r; i++) { \
                for(k = 0; k < buf->channels; k++) { \
                    data[read * buf->channels + k] = temp[i]; \
                } \
                read++; \
            } \
        } \
    } else { \
        rb_raise(eRubyAudioError, "unsupported mix from %d to %d", buf->channels, info->channels); \
    } \
\
    buf->real_size = read; \
}
DEFINE_RA_SOUND_READ_TYPE(short);
DEFINE_RA_SOUND_READ_TYPE(int);
DEFINE_RA_SOUND_READ_TYPE(float);
DEFINE_RA_SOUND_READ_TYPE(double);

/*
 * call-seq:
 *   snd.read(buf, frames) => integer
 *
 * Tries to read the given number of frames into the buffer and returns the
 * number of frames actually read.
 */
static VALUE ra_sound_read(VALUE self, VALUE buf, VALUE frames) {
    RA_SOUND *snd;
    Data_Get_Struct(self, RA_SOUND, snd);
    if(snd->closed) rb_raise(eRubyAudioError, "closed sound");

    // Get buffer struct
    RA_BUFFER *b;
    Data_Get_Struct(buf, RA_BUFFER, b);

    // Double-check frame count against buffer size
    sf_count_t f = (sf_count_t)NUM2OFFT(frames);
    if(f < 0 || f > b->size) {
        rb_raise(eRubyAudioError, "frame count invalid");
    }

    // Shortcut for 0 frame reads
    if(f == 0) {
        b->real_size = 0;
        return INT2FIX(b->real_size);;
    }

    // Read based on type
    switch(b->type) {
        case RA_BUFFER_TYPE_SHORT:
            ra_sound_read_short(snd, b, f);
            break;
        case RA_BUFFER_TYPE_INT:
            ra_sound_read_int(snd, b, f);
            break;
        case RA_BUFFER_TYPE_FLOAT:
            ra_sound_read_float(snd, b, f);
            break;
        case RA_BUFFER_TYPE_DOUBLE:
            ra_sound_read_double(snd, b, f);
            break;
    }

    // Return read
    return INT2FIX(b->real_size);
}

/*
 * call-seq:
 *   snd.write(buf) => integer
 *
 * Writes the entire contents of the given buffer to the sound and returns the
 * number of frames written.
 */
static VALUE ra_sound_write(VALUE self, VALUE buf) {
    RA_SOUND *snd;
    Data_Get_Struct(self, RA_SOUND, snd);
    if(snd->closed) rb_raise(eRubyAudioError, "closed sound");

    // Get buffer struct
    RA_BUFFER *b;
    Data_Get_Struct(buf, RA_BUFFER, b);

    // Get info struct
    SF_INFO *info;
    Data_Get_Struct(snd->info, SF_INFO, info);

    // Check buffer channels matches actual channels
    if(b->channels != info->channels) {
        rb_raise(eRubyAudioError, "channel count mismatch: %d vs %d", b->channels, info->channels);
    }

    // Write data
    sf_count_t written = 0;
    switch(b->type) {
        case RA_BUFFER_TYPE_SHORT:
            written = sf_writef_short(snd->snd, b->data, b->real_size);
            break;
        case RA_BUFFER_TYPE_INT:
            written = sf_writef_int(snd->snd, b->data, b->real_size);
            break;
        case RA_BUFFER_TYPE_FLOAT:
            written = sf_writef_float(snd->snd, b->data, b->real_size);
            break;
        case RA_BUFFER_TYPE_DOUBLE:
            written = sf_writef_double(snd->snd, b->data, b->real_size);
            break;
    }

    return OFFT2NUM(written);
}

/*
 * call-seq:
 *   snd << buf => snd
 *
 * Writes the given buffer to the string.
 *
 *   snd << buf1 << buf2
 */
static VALUE ra_sound_addbuf(VALUE self, VALUE buf) {
    ra_sound_write(self, buf);
    return self;
}

/*
 * call-seq:
 *   snd.close => nil
 *
 * Closes <i>snd</i> and frees up all memory associated with the sound. The
 * sound is unavailable for any further data operations; an error is raised if
 * such an attempt is made. Sounds are automatically closed when they are claimed
 * by the garbage collector.
 */
static VALUE ra_sound_close(VALUE self) {
    RA_SOUND *snd;
    Data_Get_Struct(self, RA_SOUND, snd);
    if(snd->closed) rb_raise(eRubyAudioError, "closed sound");

    sf_close(snd->snd);
    snd->snd = NULL;
    snd->closed = 1;
    return Qnil;
}

static VALUE ra_sound_close_safe(VALUE self) {
    return rb_rescue(ra_sound_close, self, 0, 0);
}

/*
 * call-seq:
 *   snd.closed? => true or false
 *
 * Whether or not the current sound is closed to further operations.
 */
static VALUE ra_sound_closed(VALUE self) {
    RA_SOUND *snd;
    Data_Get_Struct(self, RA_SOUND, snd);
    return snd->closed ? Qtrue : Qfalse;
}