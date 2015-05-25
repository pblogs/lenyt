//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require noframework.waypoints.min
//= require jquery.mCustomScrollbar.concat.min
//= require waypoint_custom
//= require common

jQuery(function() {
  $("a[rel~=popover], .has-popover").popover();
  return $("a[rel~=tooltip], .has-tooltip").tooltip();
});
