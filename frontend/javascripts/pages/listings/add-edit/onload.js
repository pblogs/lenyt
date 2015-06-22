var Vue = require('vue')
var request = require('browser-request')

var editing = location.pathname.match(/\/listings\/([0-9]*)/)
var listingId = editing ? +editing[1] : -1
var csrfToken = document.querySelector('[name="csrf-token"]').content

var v = new Vue({
  el: '#listings-edit-add-vue',
  data: {
    images: [],
    imagesLength: 0,
    current: 0
  },
  methods: {
    next: function () {
      var next = v.$data.current + 1
      if (next >= v.$data.images.length) {
        next = 0
      }
      setImage(next)
    },
    prev: function () {
      var previous = v.$data.current - 1
      if (previous < 0) {
        previous = v.$data.images.length - 1
      }
      setImage(previous)
    },
    removeImage: function () {
      var id = v.$data.images[v.$data.current].id
      v.$data.images.splice(v.$data.current, 1)
      v.$data.imagesLength = v.$data.images.length
      setImage(0)
      request({
        method: 'DELETE',
        headers: {
          'X-Csrf-Token': csrfToken
        },
        uri: '/api/assets/' + id,
        json: {
          product_id: listingId
        }
      }, function (){})
    }
  }
})

if (editing) {
  request({
    uri: '/api/products/' + listingId,
    json: true
  }, function (err, response, data) {
    if (err) {
      throw err
    }

    data.product.images.forEach(function (image) {
      v.$data.images.push({
        url: image.url,
        id: image.id,
        current: false,
        previous: false,
        next: false
      })
    })

    v.$data.imagesLength = v.$data.images.length
    v.$data.current = 0
    var next = 1
    var previous = v.$data.images.length-1
    if (next>=v.$data.images.length) {
      next = 0
    }
    if (previous<0) {
      previous = v.$data.images.length-1
    }
    v.$data.images.forEach(function (image, ind) {
      var type = ''
      if (ind===0) {
        type = 'current'
      } else if (ind===next) {
        type = 'next'
      } else if (ind===previous) {
        type = 'previous'
      }
      image.previous = false
      image.current = false
      image.next = false
      image[type] = true
    })
  })
}

var setImage = function (index) {
  v.$data.current = index
  var next = index + 1
  var previous = index - 1
  if (next >= v.$data.images.length) {
    next = 0
  }
  if (previous < 0) {
    previous = v.$data.images.length - 1
  }
  v.$data.images.forEach(function (image, ind) {
    image.previous = (ind === previous)
    image.current = (ind === index)
    image.next = (ind === next)
  })
}

window.vueInstance = v
