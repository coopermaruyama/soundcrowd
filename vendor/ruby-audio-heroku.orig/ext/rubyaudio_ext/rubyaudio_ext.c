#include <ruby.h>
#include <sndfile.h>

void Init_ra_buffer();
void Init_ra_soundinfo();
void Init_ra_sound();

VALUE eRubyAudioError;

/*
 * Document-module: RubyAudio
 */
/*
 * Document-class: RubyAudio::Error
 *
 * Error class for RubyAudio
 */
void Init_rubyaudio_ext() {
    // Create RubyAudio module and other setup
    VALUE mRubyAudio = rb_define_module("RubyAudio");
    eRubyAudioError = rb_define_class_under(mRubyAudio, "Error", rb_eStandardError);

    // Set up classes
    Init_ra_buffer();
    Init_ra_soundinfo();
    Init_ra_sound();

    // Export libsndfile constants
    // Major formats
    rb_define_const(mRubyAudio, "FORMAT_WAV", /* 0x010000 */ INT2FIX(SF_FORMAT_WAV));
    rb_define_const(mRubyAudio, "FORMAT_AIFF", /* 0x020000 */ INT2FIX(SF_FORMAT_AIFF));
    rb_define_const(mRubyAudio, "FORMAT_AU", /* 0x030000 */ INT2FIX(SF_FORMAT_AU));
    rb_define_const(mRubyAudio, "FORMAT_RAW", /* 0x040000 */ INT2FIX(SF_FORMAT_RAW));
    rb_define_const(mRubyAudio, "FORMAT_PAF", /* 0x050000 */ INT2FIX(SF_FORMAT_PAF));
    rb_define_const(mRubyAudio, "FORMAT_SVX", /* 0x060000 */ INT2FIX(SF_FORMAT_SVX));
    rb_define_const(mRubyAudio, "FORMAT_NIST", /* 0x070000 */ INT2FIX(SF_FORMAT_NIST));
    rb_define_const(mRubyAudio, "FORMAT_VOC", /* 0x080000 */ INT2FIX(SF_FORMAT_VOC));
    rb_define_const(mRubyAudio, "FORMAT_IRCAM", /* 0x0A0000 */ INT2FIX(SF_FORMAT_IRCAM));
    rb_define_const(mRubyAudio, "FORMAT_W64", /* 0x0B0000 */ INT2FIX(SF_FORMAT_W64));
    rb_define_const(mRubyAudio, "FORMAT_MAT4", /* 0x0C0000 */ INT2FIX(SF_FORMAT_MAT4));
    rb_define_const(mRubyAudio, "FORMAT_MAT5", /* 0x0D0000 */ INT2FIX(SF_FORMAT_MAT5));
    rb_define_const(mRubyAudio, "FORMAT_PVF", /* 0x0E0000 */ INT2FIX(SF_FORMAT_PVF));
    rb_define_const(mRubyAudio, "FORMAT_XI", /* 0x0F0000 */ INT2FIX(SF_FORMAT_XI));
    rb_define_const(mRubyAudio, "FORMAT_HTK", /* 0x100000 */ INT2FIX(SF_FORMAT_HTK));
    rb_define_const(mRubyAudio, "FORMAT_SDS", /* 0x110000 */ INT2FIX(SF_FORMAT_SDS));
    rb_define_const(mRubyAudio, "FORMAT_AVR", /* 0x120000 */ INT2FIX(SF_FORMAT_AVR));
    rb_define_const(mRubyAudio, "FORMAT_WAVEX", /* 0x130000 */ INT2FIX(SF_FORMAT_WAVEX));
    rb_define_const(mRubyAudio, "FORMAT_SD2", /* 0x160000 */ INT2FIX(SF_FORMAT_SD2));
    rb_define_const(mRubyAudio, "FORMAT_FLAC", /* 0x170000 */ INT2FIX(SF_FORMAT_FLAC));
    rb_define_const(mRubyAudio, "FORMAT_CAF", /* 0x180000 */ INT2FIX(SF_FORMAT_CAF));
#ifdef HAVE_CONST_SF_FORMAT_OGG
    rb_define_const(mRubyAudio, "FORMAT_OGG", /* 0x200000 */ INT2FIX(SF_FORMAT_OGG));
#endif

    // Subtypes from here on
    rb_define_const(mRubyAudio, "FORMAT_PCM_S8", /* 0x0001 */ INT2FIX(SF_FORMAT_PCM_S8));
    rb_define_const(mRubyAudio, "FORMAT_PCM_16", /* 0x0002 */ INT2FIX(SF_FORMAT_PCM_16));
    rb_define_const(mRubyAudio, "FORMAT_PCM_24", /* 0x0003 */ INT2FIX(SF_FORMAT_PCM_24));
    rb_define_const(mRubyAudio, "FORMAT_PCM_32", /* 0x0004 */ INT2FIX(SF_FORMAT_PCM_32));
    rb_define_const(mRubyAudio, "FORMAT_PCM_U8", /* 0x0005 */ INT2FIX(SF_FORMAT_PCM_U8));
    rb_define_const(mRubyAudio, "FORMAT_FLOAT", /* 0x0006 */ INT2FIX(SF_FORMAT_FLOAT));
    rb_define_const(mRubyAudio, "FORMAT_DOUBLE", /* 0x0007 */ INT2FIX(SF_FORMAT_DOUBLE));
    rb_define_const(mRubyAudio, "FORMAT_ULAW", /* 0x0010 */ INT2FIX(SF_FORMAT_ULAW));
    rb_define_const(mRubyAudio, "FORMAT_ALAW", /* 0x0011 */ INT2FIX(SF_FORMAT_ALAW));
    rb_define_const(mRubyAudio, "FORMAT_IMA_ADPCM", /* 0x0012 */ INT2FIX(SF_FORMAT_IMA_ADPCM));
    rb_define_const(mRubyAudio, "FORMAT_MS_ADPCM", /* 0x0013 */ INT2FIX(SF_FORMAT_MS_ADPCM));
    rb_define_const(mRubyAudio, "FORMAT_GSM610", /* 0x0020 */ INT2FIX(SF_FORMAT_GSM610));
    rb_define_const(mRubyAudio, "FORMAT_VOX_ADPCM", /* 0x0021 */ INT2FIX(SF_FORMAT_VOX_ADPCM));
    rb_define_const(mRubyAudio, "FORMAT_G721_32", /* 0x0030 */ INT2FIX(SF_FORMAT_G721_32));
    rb_define_const(mRubyAudio, "FORMAT_G723_24", /* 0x0031 */ INT2FIX(SF_FORMAT_G723_24));
    rb_define_const(mRubyAudio, "FORMAT_G723_40", /* 0x0032 */ INT2FIX(SF_FORMAT_G723_40));
    rb_define_const(mRubyAudio, "FORMAT_DWVW_12", /* 0x0040 */ INT2FIX(SF_FORMAT_DWVW_12));
    rb_define_const(mRubyAudio, "FORMAT_DWVW_16", /* 0x0041 */ INT2FIX(SF_FORMAT_DWVW_16));
    rb_define_const(mRubyAudio, "FORMAT_DWVW_24", /* 0x0042 */ INT2FIX(SF_FORMAT_DWVW_24));
    rb_define_const(mRubyAudio, "FORMAT_DWVW_N", /* 0x0043 */ INT2FIX(SF_FORMAT_DWVW_N));
    rb_define_const(mRubyAudio, "FORMAT_DPCM_8", /* 0x0050 */ INT2FIX(SF_FORMAT_DPCM_8));
    rb_define_const(mRubyAudio, "FORMAT_DPCM_16", /* 0x0051 */ INT2FIX(SF_FORMAT_DPCM_16));
#ifdef HAVE_CONST_SF_FORMAT_OGG
    rb_define_const(mRubyAudio, "FORMAT_VORBIS", /* 0x0060 */ INT2FIX(SF_FORMAT_VORBIS));
#endif

    // Endian-ness options
    rb_define_const(mRubyAudio, "ENDIAN_FILE", /* 0x00000000 */ INT2FIX(SF_ENDIAN_FILE));
    rb_define_const(mRubyAudio, "ENDIAN_LITTLE", /* 0x10000000 */ INT2FIX(SF_ENDIAN_LITTLE));
    rb_define_const(mRubyAudio, "ENDIAN_BIG", /* 0x20000000 */ INT2FIX(SF_ENDIAN_BIG));
    rb_define_const(mRubyAudio, "ENDIAN_CPU", /* 0x30000000 */ INT2FIX(SF_ENDIAN_CPU));

    // Format masks
    rb_define_const(mRubyAudio, "FORMAT_SUBMASK", /* 0x0000FFFF */ INT2FIX(SF_FORMAT_SUBMASK));
    rb_define_const(mRubyAudio, "FORMAT_TYPEMASK", /* 0x0FFF0000 */ INT2FIX(SF_FORMAT_TYPEMASK));
    rb_define_const(mRubyAudio, "FORMAT_ENDMASK", /* 0x30000000 */ INT2FIX(SF_FORMAT_ENDMASK));
}