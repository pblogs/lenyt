var request = require('browser-request')
var Vue = require('vue')
var v = new Vue({
    el: '#vue-messages',
    data: {
        conversations: []
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
})

//function scrollMessages () {
//    $('[data-toggle="popover"]').popover()
//    $('#tchat').mCustomScrollbar()
//
//    $('#tchat').mCustomScrollbar('scrollTo', 'bottom', {
//        scrollEasing: 'easeOut'
//    })
//}
