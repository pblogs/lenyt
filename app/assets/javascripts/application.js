// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require dropzone
//= require twitter/bootstrap
//= require autocomplete-rails
//= require my_items
//= require bootstrap-slider
//= require bootstrap-datepicker
//= require moment.min
//= require jquery.daterangepicker
//= require jquery.mCustomScrollbar.concat.min
//= require jquery.ui.addresspicker
//= require map_options
//= require custom
//= require common


jQuery(function() {
  $("a[rel~=popover], .has-popover").popover();
  return $("a[rel~=tooltip], .has-tooltip").tooltip();
});
