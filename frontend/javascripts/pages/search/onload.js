var Vue = require('vue')
var request = require('browser-request')
var _ = require('lodash')
var getJson = require('../../services/get-json')
var gMap = require('../../services/map')
var productMarkers = []
var map = gMap.create(document.getElementById('search_map'), gMap.coords(44.099421, -79.793701))
var gettingProducts = false
var page = 1

var tagsList = []

var getProducts = function (page) {
  gettingProducts = true
  getJson('/api/products.json?page=' + page, function (err, prods) {
    if (err) {
      return console.error(err)
    }
    var template = document.getElementsByClassName('map-pointi')[0].innerHTML

    prods.products.forEach(function (product, index) {
      var options = {
        content: template.replace(/IMAGE_URL/g, product.image).replace(/TITLE/g, product.title).replace(/PRICE/g, '$' + product.price_per_day).replace(/ID/g, product.id),
        position: gMap.coords(product.map.lat, product.map.long)
      }
      var iwindow = gMap.infoWindow(map, options).onClose(function () {
        v.$data.products[index].active = false
      })
      productMarkers.push(iwindow)
      product.active = false
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
    products: [],
    category: {
      name: '',
      id: 0
    },
    tags: {
      searchTerm: '',
      visible: false,
      list: [],
      current: -1,
      active: {},
      placeholder: 'what'
    }
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
    },
    selectCategory: function (id, name) {
      v.$data.category.name = name
      v.$data.category.id = id
    },
    selectTag: function (index) {
      selectTag(index)
    },
    hideTags: function () {
      setTimeout(function () {
        v.$data.tags.visible = false
      }, 100)
    },
    findTags: function (e) {
      if (e.keyCode === 40) {
        e.preventDefault()
        v.$data.tags.current++
        if (v.$data.tags.current === v.$data.tags.list.length) {
          v.$data.tags.current--
        }
        return
      }
      if (e.keyCode === 38) {
        e.preventDefault()
        v.$data.tags.current--
        if (v.$data.tags.current < 0) {
          v.$data.tags.current = 0
        }
        return
      }
      if (e.keyCode === 13) {
        e.preventDefault()
        selectTag(v.$data.tags.current)
      }
      v.$data.tags.current = -1
      v.$data.tags.list = tagsList.filter(function (tag) {
        return tag.name.match(v.$data.tags.searchTerm)
      })
    }
  }
})

request({
  uri: '/api/tags',
  json: true
}, function (err, response, data) {
  if (err) {
    throw err
  }
  tagsList = data.tags
  v.$data.tags.list = _.cloneDeep(tagsList)
})

var selectTag = function (index) {
  v.$data.tags.active = _.cloneDeep(v.$data.tags.list[index])
  v.$data.tags.placeholder = v.$data.tags.active.name
  v.$data.tags.searchTerm = ''
  document.getElementById('tag-input').blur()
}

getProducts(page)
