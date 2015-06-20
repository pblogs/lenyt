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
      console.log(e.keyCode)
      if (e.keyCode === 188) {
        v.$data.mails.push({
          value: v.$data.mail.replace(/\s|,/g, ''),
          status: 0
        })
        v.$data.mail = ''
      }
    },
    removeMail: function (index) {
      v.$data.mails.splice(index, 1)
    },
    sendMails: function (e) {
      e.preventDefault()

      v.$data.mails.push({
        value: v.$data.mail.replace(/\s|,/g, ''),
        status: 0
      })
      v.$data.mail = ''
      v.$data.mails.forEach(function (mail) {
        request({
          method: 'POST',
          uri: '/users/invitation',
          headers: {
            'X-Csrf-Token': csrfToken
          },
          json: {
            utf8: '✓',
            user: {
              email: mail.value
            }
          }
        }, function (err, response, data) {
          if (err) {
            throw err
          }

          if (data.success) {
            mail.status = 1
          } else {
            mail.status = -1
          }
        })
      })
    }
  }
})
