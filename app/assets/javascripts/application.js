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
// = require lenyt-app
// = require jquery
// = require jquery-ui
// = require jquery_ujs
// = require vue
// = require dropzone
// = require twitter/bootstrap
// = require autocomplete-rails
// = require my_items
// = require bootstrap-slider
// = require bootstrap-datepicker
// = require moment.min
// = require jquery.mCustomScrollbar.concat.min
// = require custom
// = require common
// = require jquery.daterangepicker
// = require jquery.raty
// = require ratyrate
// = require twitter/typeahead
// = require typeahead-addresspicker
// = require map_options
// = require gmapsjs
// = require app/products

jQuery(function () {
  $('a[rel~=popover], .has-popover').popover()
  return $('a[rel~=tooltip], .has-tooltip').tooltip()
})

$(document).ready(function () {
  if ($('#rangeCalendar').length > 0) {
    $('#product_is_available').click(function (event) {
      if ($('#product_is_available').prop('checked')) {
        $('#product_available_at').val('')
        $('#product_end_at').val('')
        $('#rangeCalendar').data('dateRangePicker').clear()
        $('#rangeCalendar').css('pointer-events', 'none')
      } else {
        $('#rangeCalendar').css('pointer-events', 'auto')
      }
    })

    $('#rangeCalendar').dateRangePicker({
      format: 'YYYY-MM-DD',
      inline: true,
      alwaysOpen: true,
      setValue: function (s, s1, s2) {
        $('#product_available_at').val(s1)
        $('#product_end_at').val(s2)
      },
      container: '#rangeCalendar'
    }).bind('datepicker-change', function (event, obj) {
      $('#product_is_available').attr('checked', false)
    })
  }

  function initialize () {
    if (!document.getElementById('map-canvas')) {
      return
    }
    lat = $('#map-canvas').data('lat')
    lng = $('#map-canvas').data('lng')
    address = $('#map-canvas').data('address')

    var myLatlng = new google.maps.LatLng(lat, lng)
    var mapOptions = {
      zoom: 14,
      center: myLatlng
    }
    var map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)

    var marker = new google.maps.Marker({
      position: myLatlng,
      map: map,
      title: address
    })
  }
  google.maps.event.addDomListener(window, 'load', initialize)
})
