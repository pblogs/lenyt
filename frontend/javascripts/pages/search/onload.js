/* global google */
var Vue = require('vue')
var getJson = require('../../services/get-json')
var productMarkers = []
var map

var v = new Vue({
  el: '#lenyt-search',
  data: {
    products: []
  },
  methods: {
    toggleActive: function (e) {
      var element = e.target
      while (element.dataset.index === undefined && element !== document.body) {
        element = element.parentNode
      }
      var index = +element.dataset.index
      v.$data.products[index].active = !v.$data.products[index].active
      if (v.$data.products[index].active) {
        productMarkers[index].open(map)
      } else {
        productMarkers[index].close()
      }
    }
  }
})

getJson('/products.json', function (err, prods) {
  if (err) {
    return console.error(err)
  }
  var template = document.getElementsByClassName('map-pointi')[0].innerHTML

  map = new google.maps.Map(document.getElementById('search_map'), {
    zoom: 8,
    center: new google.maps.LatLng(44.099421, -79.793701)
  })

  prods.products.forEach(function (product, index) {
    var options = {
      content: template.replace(/IMAGE_URL/g, product.image).replace(/TITLE/g, product.title).replace(/PRICE/g, '$' + product.price_per_day),
      position: new google.maps.LatLng(product.map.lat, product.map.long)
    }
    var iwindow = new google.maps.InfoWindow(options)
    iwindow.open(map)
    google.maps.event.addListener(iwindow, 'closeclick', function () {
      v.$data.products[index].active = false
    })
    productMarkers.push(iwindow)
    product.active = true
  })

  v.$data.products = prods.products
})
