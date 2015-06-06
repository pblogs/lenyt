var Vue = require('vue')
var request = require('browser-request')

var id = location.pathname.match(/\/([^\/]*)\/?$/)[1]

var realRating = 0

var v = new Vue({
  el: '#lenyt-vue-listings-show',
  data: {
    product: {},
    current: 0,
    imagesLength: 0,
    rating: 0
  },
  methods: {
    next: function () {
      var next = v.$data.current+1
      if (next>=v.$data.product.images.length) {
        next = 0
      }
      setImage(next)
    },
    prev: function () {
      var previous = v.$data.current-1
      if (previous<0) {
        previous = v.$data.product.images.length-1
      }
      setImage(previous)
    },
    star: function (event) {
      var perc = event.layerX
      v.$data.rating = ((perc/20)|0)+1
    },
    resetStar: function () {
      v.$data.rating = realRating
    }
  }
})

var setImage = function (index) {
  v.$data.current = index
  var next = index+1
  var previous = index-1
  if (next>=v.$data.product.images.length) {
    next = 0
  }
  if (previous<0) {
    previous = v.$data.product.images.length-1
  }
  v.$data.product.images.forEach(function (image, ind) {
    image.previous = (ind===previous)
    image.current = (ind===index)
    image.next = (ind===next)
  })
}

request({
  uri: '/api/products/' + id + '.json',
  json:true
}, function (err, response, data) {
  if (err) {
    return console.error(err)
  }
  data.product.images.forEach(function (image, index) {
    image.previous = (index===data.product.images.length - 1)
    image.current = (index===0)
    image.next = (index===1)
  })
  v.$data.product = data.product
  v.$data.rating = data.product.user.rating.avg
  realRating = data.product.user.rating.avg
  v.$data.imagesLength = data.product.images.length
})