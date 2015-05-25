if ($("#addresspicker").length > 0) {
  $(function() {
    var addresspicker = $( "#addresspicker" ).addresspicker({
      componentsFilter: 'country:CA'
    });
    var addresspickerMap = $( "#product_address" ).addresspicker({
      regionBias: "ca",
      updateCallback: showCallback,
      mapOptions: {
        zoom: 15,
        center: new google.maps.LatLng(46, 2),
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

  });
};

