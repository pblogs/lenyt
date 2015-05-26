$(document).ready(function () {
  window.vm = new Vue({
    el: '#vue-el',
    data: {
      articleTitle: '',
      sentOn: '',
      days: 0,
      total: 0,
      conversationId: 0,
      imageUrl: '',
      messages: [],
      message: ''
    }
  })

  getMessages(
    $('.conversations_list').data('conversationId'),
    $('.conversations_list').data('userId')
  )

  $('ul.conversations_list li').click(function(event) {
    if (!($(this).hasClass( "active" ))) {
      $('.tab-content').css({opacity: '0.4',transition: '0.5'});;
      getMessages(
        $(this).data('conversationId'),
        $('.conversations_list').data('userId')
      );
    };
  });

  if ($('button.send').length > 0) {
    $('button.send').on('click', function(event) {
      event.preventDefault();
      message = vm.$data.message;
      $.ajax({
        url: '/messages',
        type: 'POST',
        dataType: 'json',
        data: {
          conversation_id: $(this).data('conversation-id'),
          message: message
        },
      })
      .done(function(response) {
        vm.$data.messages.push({
          sender_name: 'You',
          isLeft: false,
          created_at: moment(response.created_at).format('MMMM DD - h:mm a' ),
          body: response.message.body
        });
        vm.$data.message = '';;
        setTimeout(scrollMessages);
      })
      .fail(function(response) {
        console.log("error");
      })
      .always(function(response) {
        console.log("complete");
      });
    });
  };
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
    vm.$data.conversationId = conversation.id
    $('.tab-content').css('opacity', '1.0');
    setTimeout(scrollMessages);
  })
}

function scrollMessages() {
  $('[data-toggle="popover"]').popover();
  $("#tchat").mCustomScrollbar();

  $("#tchat").mCustomScrollbar("scrollTo","bottom",{
    scrollEasing:"easeOut"
  });
}
