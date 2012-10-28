#ifndef RA_SOUNDINFO_H
#define RA_SOUNDINFO_H

#include <ruby.h>
#include <sndfile.h>

void Init_ra_soundinfo();

/*** Initialization and Memory Manangement ***/
static VALUE ra_soundinfo_allocate(VALUE klass);
static void  ra_soundinfo_free(SF_INFO *info);

/*** Instance Methods ***/
static VALUE ra_soundinfo_valid(VALUE self);
static VALUE ra_soundinfo_frames(VALUE self);
static VALUE ra_soundinfo_samplerate(VALUE self);
static VALUE ra_soundinfo_samplerate_set(VALUE self, VALUE new_samplerate);
static VALUE ra_soundinfo_channels(VALUE self);
static VALUE ra_soundinfo_channels_set(VALUE self, VALUE new_channels);
static VALUE ra_soundinfo_format(VALUE self);
static VALUE ra_soundinfo_format_set(VALUE self, VALUE new_format);
static VALUE ra_soundinfo_sections(VALUE self);
static VALUE ra_soundinfo_seekable(VALUE self);

#endif        //  #ifndef RA_SOUNDINFO_H