var Vue = require('vue')
var request = require('browser-request')
var csrfToken = document.querySelector('[name="csrf-token"]').content
var dateFrom = new Date()
var dateTo = new Date()

var id = window.location.pathname.match(/\/([^\/]*)\/?$/)[1]

var realRating = 0
var disabled = false

var v = new Vue({
  el: '#lenyt-vue-listings-show',
  data: {
    product: {},
    current: 0,
    imagesLength: 0,
    rating: 0,
    dw: 0,
    days: 0,
    insurance: 1,
    alertMessage: ''
  },
  methods: {
    next: function () {
      var next = v.$data.current + 1
      if (next >= v.$data.product.images.length) {
        next = 0
      }
      setImage(next)
    },
    prev: function () {
      var previous = v.$data.current - 1
      if (previous < 0) {
        previous = v.$data.product.images.length - 1
      }
      setImage(previous)
    },
    star: function (event) {
      if (disabled) {
        return
      }
      var perc = event.layerX
      v.$data.rating = ((perc / 20) | 0) + 1
    },
    resetStar: function () {
      if (disabled) {
        return
      }
      v.$data.rating = realRating
    },
    vote: function () {
      if (disabled) {
        return
      }
      realRating = v.$data.rating
      request({
        method: 'POST',
        uri: '/api/rate/',
        headers: {
          'X-Csrf-Token': csrfToken
        },
        json: {
          score: v.$data.rating,
          dimension: 'trust',
          id: v.$data.product.user.id,
          klass: 'User'
        }
      }, function () {
      })
    },
    insuranceDW: function () {
      v.$data.insurance = 1
    },
    insuranceFD: function () {
      v.$data.insurance = 2
    },
    request: function () {
      if (v.$data.days === 0) {
        return
      }
      request({
        method: 'POST',
        uri: '/api/requests',
        headers: {
          'X-Csrf-Token': csrfToken
        },
        json: {
          product_id: v.$data.product.id,
          amount: '150',
          rent_from_date: getYMD(dateFrom),
          rent_to_date: getYMD(dateTo),
          insurance: v.$data.insurance
        }
      }, function () {
        v.$data.alertMessage = 'Request sent, no error handling ^_^'
      })
    },
    closeAlert: function () {
      v.$data.alertMessage = ''
    }
  }
})

var setImage = function (index) {
  v.$data.current = index
  var next = index + 1
  var previous = index - 1
  if (next >= v.$data.product.images.length) {
    next = 0
  }
  if (previous < 0) {
    previous = v.$data.product.images.length - 1
  }
  v.$data.product.images.forEach(function (image, ind) {
    image.previous = (ind === previous)
    image.current = (ind === index)
    image.next = (ind === next)
  })
}

var calculateDw = function () {
  var from = dateFrom.getTime()
  var to = dateTo.getTime()
  if (from >= to || from <= Date.now()) {
    v.$data.dw = 0
    v.$data.days = 0
    return
  }

  var daily = v.$data.product.price_per_day
  var days = ((to - from) / 86400000) // 86400000ms in 24 hours
  v.$data.days = days
  v.$data.dw = daily * 0.15 + days * daily * 0.03
}

var getYMD = function (date) {
  var year = date.getFullYear()
  var month = date.getMonth() + 1
  var day = date.getDate()
  if (month < 10) {
    month = '0' + month
  }
  if (day < 10) {
    day = '0' + day
  }
  return year + '-' + month + '-' + day
}

request({
  uri: '/api/products/' + id + '.json',
  json: true
}, function (err, response, data) {
  if (err) {
    return console.error(err)
  }
  data.product.images.forEach(function (image, index) {
    image.previous = (index === data.product.images.length - 1)
    image.current = (index === 0)
    image.next = (index === 1)
  })
  disabled = data.product.voted
  v.$data.product = data.product
  v.$data.rating = data.product.user.rating.avg
  realRating = data.product.user.rating.avg
  v.$data.imagesLength = data.product.images.length
})

window.jQuery('#dpd1').val('').datepicker().on('changeDate', function (e) {
  dateFrom = e.date
  calculateDw()
})
window.jQuery('#dpd2').val('').datepicker().on('changeDate', function (e) {
  dateTo = e.date
  calculateDw()
})
