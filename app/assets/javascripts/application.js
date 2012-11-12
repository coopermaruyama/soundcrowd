// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require jquery.jplayer.min
//= require underscore
//= require backbone
//= require .//soundcrowd
//= require_tree ../templates/
//= require_tree .//models
//= require_tree .//collections
//= require_tree .//views
//= require_tree .//routers
//= require_tree .

Sequencer = function(arr, opts) {

  arr  = arr || [];

  var running = false;
  var self    = this;

  this.isRunning = function() {
    return running;
  };

  this.start = function(cb) {
    cb && self.add(cb);
    running = true;
    this.next();
  };


  this.stop = function() {
    running = false;
  };

  this.startCallback = function(cb) {
    return function() {
      self.next();
    };
  };

  this.add = function(cb) {
    arr.push(cb);
  };

  this.next = function() {
    if (running && (arr.length != 0)) {
      arr.shift()(function() {
          self.next();
        });
    }
  };

};

