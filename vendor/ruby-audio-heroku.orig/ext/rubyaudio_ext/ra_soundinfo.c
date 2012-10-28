#include "ra_soundinfo.h"

extern VALUE eRubyAudioError;

/*
 * Class <code>CSoundInfo</code> is a very light wrapper around the
 * <code>SF_INFO</code> struct exposed by libsndfile. It provides information
 * about open sound files like format, length, samplerate, channels, and other
 * things. In addition it can be used to specify the format of new sound files.
 */
void Init_ra_soundinfo() {
    VALUE mRubyAudio = rb_define_module("RubyAudio");
    VALUE cRASoundInfo = rb_define_class_under(mRubyAudio, "CSoundInfo", rb_cObject);
    rb_define_alloc_func(cRASoundInfo, ra_soundinfo_allocate);
    rb_define_method(cRASoundInfo, "valid?",      ra_soundinfo_valid, 0);
    rb_define_method(cRASoundInfo, "frames",      ra_soundinfo_frames, 0);
    rb_define_method(cRASoundInfo, "samplerate",  ra_soundinfo_samplerate, 0);
    rb_define_method(cRASoundInfo, "samplerate=", ra_soundinfo_samplerate_set, 1);
    rb_define_method(cRASoundInfo, "channels",    ra_soundinfo_channels, 0);
    rb_define_method(cRASoundInfo, "channels=",   ra_soundinfo_channels_set, 1);
    rb_define_method(cRASoundInfo, "format",      ra_soundinfo_format, 0);
    rb_define_method(cRASoundInfo, "format=",     ra_soundinfo_format_set, 1);
    rb_define_method(cRASoundInfo, "sections",    ra_soundinfo_sections, 0);
    rb_define_method(cRASoundInfo, "seekable",    ra_soundinfo_seekable, 0);
}

static VALUE ra_soundinfo_allocate(VALUE klass) {
    SF_INFO *info = ALLOC(SF_INFO);
    memset(info, 0, sizeof(SF_INFO));
    VALUE self = Data_Wrap_Struct(klass, NULL, ra_soundinfo_free, info);
    return self;
}

static void ra_soundinfo_free(SF_INFO *info) {
    xfree(info);
}

/*
 * call-seq:
 *   info.valid? => true or false
 *
 * Calls <code>sf_format_check</code> on the underlying <code>SF_INFO</code>
 * struct and returns true or false based on validity. Used when creating a new
 * sound file to check that the format has enough information to properly create
 * a new sound.
 */
static VALUE ra_soundinfo_valid(VALUE self) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    return sf_format_check(info) ? Qtrue : Qfalse;
}

/*
 * call-seq:
 *   info.frames => integer
 *
 * Returns the number of frames in the associated sound file.
 */
static VALUE ra_soundinfo_frames(VALUE self) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    return OFFT2NUM(info->frames);
}

/*
 * call-seq:
 *   info.samplerate => integer
 *
 * Returns the samplerate of the associated sound file.
 */
static VALUE ra_soundinfo_samplerate(VALUE self) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    return INT2FIX(info->samplerate);
}

/*
 * call-seq:
 *   info.samplerate = integer => integer
 *
 * Set the samplerate for a new sound created with the given info object.
 */
static VALUE ra_soundinfo_samplerate_set(VALUE self, VALUE new_samplerate) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    info->samplerate = FIX2INT(new_samplerate);
    return new_samplerate;
}

/*
 * call-seq:
 *   info.channels => integer
 *
 * Returns the number of channels in the associated sound file.
 */
static VALUE ra_soundinfo_channels(VALUE self) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    return INT2FIX(info->channels);
}

/*
 * call-seq:
 *   info.channels = integer => integer
 *
 * Set the number of channels for a new sound created with the given info object.
 */
static VALUE ra_soundinfo_channels_set(VALUE self, VALUE new_channels) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    info->channels = FIX2INT(new_channels);
    return new_channels;
}

/*
 * call-seq:
 *   info.format => integer
 *
 * Returns the format as a combination of binary flags of the associated sound file.
 */
static VALUE ra_soundinfo_format(VALUE self) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    return INT2FIX(info->format);
}

/*
 * call-seq:
 *   info.format = integer => integer
 *
 * Set the format for a new sound created with the given info object.
 *
 *   info = RubyAudio::CSoundInfo.new
 *   info.format = RubyAudio::FORMAT_WAV|RubyAudio::FORMAT_PCM_16
 */
static VALUE ra_soundinfo_format_set(VALUE self, VALUE new_format) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    info->format = FIX2INT(new_format);
    return new_format;
}

/*
 * call-seq:
 *   info.sections => integer
 *
 * Returns the number of sections in the associated sound file.
 */
static VALUE ra_soundinfo_sections(VALUE self) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    return INT2FIX(info->sections);
}

/*
 * call-seq:
 *   info.seekable => true or false
 *
 * Whether seeking is supported for the associated sound file.
 */
static VALUE ra_soundinfo_seekable(VALUE self) {
    SF_INFO *info;
    Data_Get_Struct(self, SF_INFO, info);
    return info->seekable ? Qtrue : Qfalse;
}