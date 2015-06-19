var request = require('browser-request')
var Vue = require('vue')
var moment = require('moment')
var _ = require('lodash')
var csrfToken = document.querySelector('[name="csrf-token"]').content

function scrollMessages() {
  setTimeout(function () {
    $('[data-toggle="popover"]').popover()

    $('#tchat').mCustomScrollbar('scrollTo', 'bottom', {
      scrollEasing: 'easeOut'
    })
  })
}

function sendMessage (event) {
  var message = v.$data.message
  v.$data.message = ''
  event.preventDefault()
  request({
    method: 'POST',
    uri: '/messages',
    headers: {
      'X-Csrf-Token': csrfToken
    },
    json: {
      conversation_id: v.$data.current.id,
      message: message
    }
  }, function () {})
}


Vue.filter('dateTime', function (date, format) {
  return moment(date).format(format.replace(/'/g, ''))
})

var v = new Vue({
  el: '#vue-messages',
  data: {
    conversations: [],
    current: {},
    message: ''
  },
  methods: {
    switchConversation: function (index) {
      v.$data.current = v.$data.conversations[index]
      scrollMessages()
    },
    sendMessageOnEnter: function (event) {
      if (event.keyCode === 13) {
        sendMessage(event)
      }
    },
    sendMessage: function (event) {
      sendMessage(event)
    }
  }
})

window.v = v

request({
  uri: '/api/conversations',
  json: true
}, function (err, response, data) {
  if (err) {
    throw err
  }

  v.$data.conversations = data.conversations
  v.$data.current = v.$data.conversations[0]
  scrollMessages()
  request({
    uri: '/api/users/current.json',
    json: true
  }, function (err, response, currentUser) {
    if (err) {
      throw err
    }
    scrollMessages()

    socket.on('message', function (newMessage) {
      var chatUserName
      if (currentUser.username === newMessage.sender_name) {
        chatUserName = newMessage.recipient_name
      } else {
        chatUserName = newMessage.sender_name
      }

      v.$data.conversations.forEach(function (conversation) {
        if (conversation.participant.username !== chatUserName) {
          return
        }

        conversation.messages.push(newMessage)
      })


      //if (v.$data.current.participant.username !== chatUserName) {
      //  return
      //}
      //
      //v.$data.current.messages.push(newMessage)
      scrollMessages()
    })
  })
})

