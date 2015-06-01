$(function () {
  if ($('#map').length > 0) {
    var addressPicker = new AddressPicker({
      map: {
        id: '#map', displayMarker: true,
        center: new google.maps.LatLng(43.7182412, -79.378058),
        mapTypeId: google.maps.MapTypeId.ROADMAP,
        zoom: 12
      },
      marker: {
        draggable: true,
        visible: true
      },
      zoomForLocation: 12,
      draggable: true,
      reverseGeocoding: true,
      autocompleteService: {
        componentRestrictions: {
          country: 'CA'
        }
      }
    })

    $('#product_address').typeahead(null, {
      displayKey: 'description',
      source: addressPicker.ttAdapter()
    })
    addressPicker.bindDefaultTypeaheadEvent($('#product_address'))
    $(addressPicker).on('addresspicker:selected', function (event, result) {
      $('#product_latitude').val(result.lat())
      $('#product_longitude').val(result.lng())
      $('#product_address').val(result.address())
      $('#product_locality').val(result.nameForType('locality'))
      $('#product_administrative_area_level_2').val(result.nameForType('administrative_area_level_2'))
      $('#product_administrative_area_level_1').val(result.nameForType('administrative_area_level_1'))
      $('#product_country').val(result.nameForType('country'))
      $('#product_postal_code').val(result.nameForType('postal_code'))
      result.addressTypes().forEach(function (type) {
        console.log('  ' + type + ': ' + result.nameForType(type))
      })
    })
  }
})
