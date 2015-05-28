$(function() {
  if ($( "#map" ).length > 0) {
    var addresspicker = $( "#addresspicker" ).addresspicker({
      componentsFilter: 'country:CA'
    });
    var addresspickerMap = $( "#product_address" ).addresspicker({
      regionBias: "CA",
      updateCallback: showCallback,
      mapOptions: {
        zoom: 12,
        center: new google.maps.LatLng(43.7182412, -79.378058),
        scrollwheel: false,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      },
      elements: {
        map:      "#map",
        lat:      "#product_latitude",
        lng:      "#product_longitude",
        //street_number: '#street_number',
        //route: '#route',
        locality: '#locality',
        administrative_area_level_2: '#product_administrative_area_level_2',
        administrative_area_level_1: '#product_administrative_area_level_1',
        country:  '#product_country',
        postal_code: '#product_postal_code',
        type:    '#product_location_type'
      }
    });

    var gmarker = addresspickerMap.addresspicker( "marker");

    gmarker.setVisible(true);

    addresspickerMap.addresspicker( "updatePosition");

    $('#reverseGeocode').change(function(){
      $("#product_address").addresspicker("option", "reverseGeocode", ($(this).val() === 'true'));
    });

    function showCallback(geocodeResult, parsedGeocodeResult){
      $('#callback_result').text(JSON.stringify(parsedGeocodeResult, null, 4));
    }
    // Update zoom field
    var map = $("#product_address").addresspicker("map");
    google.maps.event.addListener(map, 'idle', function(){
      $('#zoom').val(map.getZoom());
    });

    var geocoder;
    geocoder = new google.maps.Geocoder();

    google.maps.event.addListener(gmarker, 'dragend', function() {
      //updateMarkerStatus('Drag ended');
      geocodePosition(gmarker.getPosition());
    });

    function geocodePosition(pos) {
      geocoder.geocode({
        latLng: pos
      }, function(responses) {
        if (responses && responses.length > 0) {
          $('#product_address').val(responses[0].formatted_address)
          //console.log(responses[0].formatted_address);
        } else {
          $('#product_address').val('Cannot determine address at this location.');
        }
      });
    }
  };
});
