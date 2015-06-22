$(function(){

});

$(document).ready(function(){
  $('[data-toggle="popover"]').popover();
  var tChat = $("#tchat")
  tChat.mCustomScrollbar();

  tChat.mCustomScrollbar("scrollTo","bottom",{
    scrollEasing:"easeOut"
  });
});
