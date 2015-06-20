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
        addMail()
      }
    },
    removeMail: function (index) {
      v.$data.mails.splice(index, 1)
    },
    sendMails: function (e) {
      e.preventDefault()

      if (addMail()) {
        return
      }

      v.$data.mails.forEach(function (mail) {
        if (mail.status !== 0) {
          return
        }
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
            mail.message = data.errors.email[0]
            mail.status = -1
          }
        })
      })
    }
  }
})

var addMail = function () {
  var mail = v.$data.mail.replace(/\s|,/g, '')
  if (!mail.length) {
    return false
  }
  for (var i = 0, l = v.$data.mails.length; i < l; i++) {
    if (v.$data.mails[i].value === mail) {
      v.$data.mail = ''
      return false
    }
  }
  v.$data.mails.push({
    value: mail,
    status: 0,
    message: ''
  })
  v.$data.mail = ''
  return true
}
