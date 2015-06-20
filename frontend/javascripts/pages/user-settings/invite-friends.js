var Vue = require('vue')
var request = require('browser-request')
var csrfToken = document.querySelector('[name="csrf-token"]').content

var v = new Vue({
  el: '#vue-email',
  data: {
    mail: '',
    mails: []
  },
  methods: {
    switchOnComma: function (e) {
      if (e.keyCode === 188) {
        v.$data.mails.push(v.$data.mail.replace(/\s|,/g, ''))
        v.$data.mail = ''
      }
    }
  }
})
