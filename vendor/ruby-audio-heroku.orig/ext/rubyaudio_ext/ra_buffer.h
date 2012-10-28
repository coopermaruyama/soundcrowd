#ifndef RA_BUFFER_H
#define RA_BUFFER_H

#include <ruby.h>

typedef enum {
    RA_BUFFER_TYPE_SHORT,
    RA_BUFFER_TYPE_INT,
    RA_BUFFER_TYPE_FLOAT,
    RA_BUFFER_TYPE_DOUBLE
} BUFFER_TYPE;

typedef struct {
    BUFFER_TYPE type;
    void *data;
    long size;
    long real_size;
    int channels;
} RA_BUFFER;

void Init_ra_buffer();

/*** Initialization and Memory Manangement ***/
static VALUE ra_buffer_allocate(VALUE klass);
static void  ra_buffer_free(RA_BUFFER *buf);

/*** Instance Methods ***/
static VALUE ra_buffer_init(int argc, VALUE *argv, VALUE self);
static VALUE ra_buffer_init_copy(VALUE copy, VALUE buf);
static VALUE ra_buffer_channels(VALUE self);
static VALUE ra_buffer_size(VALUE self);
static VALUE ra_buffer_real_size(VALUE self);
static VALUE ra_buffer_real_size_set(VALUE self, VALUE new_real_size);
static VALUE ra_buffer_type(VALUE self);
static VALUE ra_buffer_each(VALUE self);
static VALUE ra_buffer_aref(VALUE self, VALUE index);
static VALUE ra_buffer_index_get(RA_BUFFER *buf, long i);
static VALUE ra_buffer_aset(VALUE self, VALUE index, VALUE val);
static void ra_buffer_index_set(RA_BUFFER *buf, long i, VALUE val);

#endif        //  #ifndef RA_BUFFER_H