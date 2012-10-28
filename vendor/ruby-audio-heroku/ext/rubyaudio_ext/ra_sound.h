#ifndef RA_SOUND_H
#define RA_SOUND_H

#include <ruby.h>
#include <sndfile.h>
#include "ra_soundinfo.h"
#include "ra_buffer.h"

typedef struct {
    SNDFILE *snd;
    VALUE info;
    VALUE vio_source;
    int mode;
    int closed;
} RA_SOUND;

void Init_ra_sound();

/*** Initialization and Memory Manangement ***/
static VALUE ra_sound_allocate(VALUE klass);
static void  ra_sound_mark(RA_SOUND *snd);
static void  ra_sound_free(RA_SOUND *snd);

/*** Singleton Methods ***/
static VALUE ra_sound_s_open(int argc, VALUE *argv, VALUE klass);

/*** Instance Methods ***/
static VALUE ra_sound_init(VALUE self, VALUE path, VALUE mode, VALUE info);
static VALUE ra_sound_info(VALUE self);
static VALUE ra_sound_seek(VALUE self, VALUE frames, VALUE whence);
static VALUE ra_sound_read(VALUE self, VALUE buf, VALUE frames);
static VALUE ra_sound_write(VALUE self, VALUE buf);
static VALUE ra_sound_addbuf(VALUE self, VALUE buf);
static VALUE ra_sound_close(VALUE self);
static VALUE ra_sound_close_safe(VALUE self);
static VALUE ra_sound_closed(VALUE self);

#endif        //  #ifndef RA_SOUND_H