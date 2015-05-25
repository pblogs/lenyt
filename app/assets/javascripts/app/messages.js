
$(document).ready(function () {
  window.vm = new Vue({
    el: '#vue-el',
    data: {
      articleTitle: '',
      sentOn: '',
      days: 0,
      total: 0,
      imageUrl: '',
      messages: []
    }
  })

  getMessages(
    $('.conversations_list').data('conversationId'),
    $('.conversations_list').data('userId')
  )

  $('ul.conversations_list li').click(function(event) {
    $('.tab-content').css({
      opacity: '0.4',
      transition: '0.5'
    });;
    getMessages(
      $(this).data('conversationId'),
      $('.conversations_list').data('userId')
    );
  });
});

function getMessages(id, user_id) {
  $.getJSON( 'conversations/' + id, {
    format: 'json'
  }).done(function( data ) {
    conversation = data.conversation;

    $.each( conversation.messages, function( i, message ) {
      message.created_at = moment(message.created_at).format('MMMM DD - h:mm a' );
      if ( message.sender_id === user_id ) {
        message.isLeft = false
        message.sender_name = 'You'
      } else {
        message.isLeft = true
      }
    });

    vm.$data.articleTitle = conversation.request.article.title
    vm.$data.sentOn = moment(conversation.request.sent_on).format('DD/MM/YYYY' );
    vm.$data.days = conversation.request.days
    vm.$data.total = conversation.request.total
    vm.$data.messages = conversation.messages
    vm.$data.imageUrl = conversation.request.image_url
    $('.tab-content').css('opacity', '1.0');
  })
}

function scrollMessages() {
  $('[data-toggle="popover"]').popover();
  $("#tchat").mCustomScrollbar();

  $("#tchat").mCustomScrollbar("scrollTo","bottom",{
    scrollEasing:"easeOut"
  });
}
