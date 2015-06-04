var Vue = require('vue')

var v = new Vue({
  el: '#listings-edit-add-vue',
  data: {
    images: [],
    imagesLength: 0,
    current: 0
  },
  methods: {
    next: function () {
      var next = v.$data.current+1
      if (next>=v.$data.images.length) {
        next = 0
      }
      setImage(next)
    },
    prev: function () {
      var previous = v.$data.current-1
      if (previous<0) {
        previous = v.$data.images.length-1
      }
      setImage(previous)
    }
  }
})

var setImage = function (index) {
  v.$data.current = index
  var next = index+1
  var previous = index-1
  if (next>=v.$data.images.length) {
    next = 0
  }
  if (previous<0) {
    previous = v.$data.images.length-1
  }
  v.$data.images.forEach(function (image, ind) {
    image.previous = (ind===previous)
    image.current = (ind===index)
    image.next = (ind===next)
  })
}

window.vueInstance = v
