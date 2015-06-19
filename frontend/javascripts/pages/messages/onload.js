var request = require('browser-request')
var Vue = require('vue')
var moment = require('moment')
var _ = require('lodash')

Vue.filter('dateTime', function (date, format) {
    return moment(date).format(format.replace(/'/g, ''))
})

var v = new Vue({
    el: '#vue-messages',
    data: {
        conversations: [],
        current: {}
    },
    methods: {
        switchConversation: function (index) {
            v.$data.current = _.assign({}, v.$data.conversations[index])
            scrollMessages()
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
    v.$data.current = _.assign({}, v.$data.conversations[0])
})

function scrollMessages () {
    setTimeout(function () {
        $('[data-toggle="popover"]').popover()

        $('#tchat').mCustomScrollbar('scrollTo', 'bottom', {
            scrollEasing: 'easeOut'
        })
    }, 50)
}

//function scrollMessages () {
//    $('[data-toggle="popover"]').popover()
//    $('#tchat').mCustomScrollbar()
//
//    $('#tchat').mCustomScrollbar('scrollTo', 'bottom', {
//        scrollEasing: 'easeOut'
//    })
//}
