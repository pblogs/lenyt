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
//= require jquery.mCustomScrollbar.concat.min
//= require jquery.ui.addresspicker
//= require map_options
//= require custom
//= require common
//= require jquery.daterangepicker
//= require jquery.raty
//= require ratyrate

jQuery(function() {
  $("a[rel~=popover], .has-popover").popover();
  return $("a[rel~=tooltip], .has-tooltip").tooltip();
});

$(document).ready(function(){
  if ($('#rangeCalendar').length > 0) {
    $("#rangeCalendar").dateRangePicker({
     format: 'YYYY-MM-DD',
     inline:true,
     alwaysOpen:true,
     container: '#rangeCalendar'
    }).bind('datepicker-change',function(event,obj){
      console.log(obj.date1);
      $('#product_available_at').val(obj.date1)
      $('#product_end_at').val(obj.date2)

      // obj will be something like this:
      // {
      //    date1: (Date object of the earlier date),
      //    date2: (Date object of the later date),
      //    value: "2013-06-05 to 2013-06-07"
      // }
    });
  };


    function initialize() {
      if (!document.getElementById('map-canvas')) {
        return;
      }
      lat = $('#map-canvas').data('lat');
      lng = $('#map-canvas').data('lng');
      address = $('#map-canvas').data('address');

      var myLatlng = new google.maps.LatLng(lat,lng);
      var mapOptions = {
        zoom: 14,
        center: myLatlng
      }
      var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

      var marker = new google.maps.Marker({
        position: myLatlng,
        map: map,
        title: address
      });
    }
    google.maps.event.addDomListener(window, 'load', initialize);
});
