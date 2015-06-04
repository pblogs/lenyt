/* global google */
module.exports = {
  create: function (el, coords) {
    return new google.maps.Map(el, {
      zoom: 8,
      center: coords
    })
  },
  coords: function (lat, long) {
    return new google.maps.LatLng(lat, long)
  },
  infoWindow: function (map, options) {
    var window = new google.maps.InfoWindow(options)
    return {
      open: function () {
        window.open(map)
        return this
      },
      close: function () {
        window.close()
        return this
      },
      onClose: function (callback) {
        google.maps.event.addListener(window, 'closeclick', callback)
        return this
      }
    }
  }
}
