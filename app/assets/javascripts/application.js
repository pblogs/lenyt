// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require vue
//= require twitter/bootstrap
//= require autocomplete-rails
//= require bootstrap-slider
//= require bootstrap-datepicker
//= require moment.min
//= require jquery.daterangepicker
//= require jquery.mCustomScrollbar.concat.min
//= require custom
//= require moment

jQuery(function() {
  $("a[rel~=popover], .has-popover").popover();
  return $("a[rel~=tooltip], .has-tooltip").tooltip();
});

$(document).ready(function () {
  window.vm = new Vue({
    el: '#vue-el',
    data: {
      messages: []
    }
  })

  getMessages(
    $('.conversations_list').data('conversationId'),
    $('.conversations_list').data('userId')
  )

  $('ul.conversations_list li').click(function(event) {
    getMessages(
      $(this).data('conversationId'),
      $('.conversations_list').data('userId')
    )
  });
});

function getMessages(id, user_id) {
  $.getJSON( 'messages/' + id, {
    format: 'json'
  }).done(function( data ) {
    $.each( data.messages, function( i, message ) {
      message.created_at = moment(message.created_at).format('MMMM DD - h:mm a' );
      if ( message.sender_id === user_id ) {
        message.isLeft = false
        message.sender = 'You'
      } else {
        message.isLeft = true
      }
    });
    vm.$data.messages = data.messages
  })
}
