var Vue = require('vue')
var getJson = require('../../services/get-json')
var gMap = require('../../services/map')
var productMarkers = []
var map = gMap.create(document.getElementById('search_map'), gMap.coords(44.099421, -79.793701))
var gettingProducts = false
var page = 1

var getProducts = function (page) {
  gettingProducts = true
  getJson('/api/products.json?page=' + page, function (err, prods) {
    if (err) {
      return console.error(err)
    }
    var template = document.getElementsByClassName('map-pointi')[0].innerHTML

    prods.products.forEach(function (product, index) {
      var options = {
        content: template.replace(/IMAGE_URL/g, product.image).replace(/TITLE/g, product.title).replace(/PRICE/g, '$' + product.price_per_day),
        position: gMap.coords(product.map.lat, product.map.long)
      }
      var iwindow = gMap.infoWindow(map, options).open().onClose(function () {
        v.$data.products[index].active = false
      })
      productMarkers.push(iwindow)
      product.active = true
      v.$data.products.push(product)
    })
    if (prods.products.length) {
      gettingProducts = false
    }
  })
}

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
    },
    scroll: function (e) {
      if (e.target.scrollTop + 700 > e.target.scrollHeight && !gettingProducts) {
        getProducts(++page)
      }
    }
  }
})

getProducts(page)
