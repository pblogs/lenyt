$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  // grap our upload form by its id
  $("#new_form").dropzone({
    url: '/users/upload_avatar',
    method: 'put',
    maxFiles: 1,
    maxFilesize: 1,
    uploadMultiple: false,
    // changed the passed param to one accepted by
    // our rails app
    paramName: "user[avatar]",
    // show remove links on each image upload
    addRemoveLinks: true,
    // if the upload was successful
    success: function(file, response){
      var file_url = $(file.previewTemplate).find('.dz-image img').attr('src');
      appendContent(file_url, response.id);
      $(file.previewTemplate).find('.dz-remove').attr('href', '/users/delete_avatar');
      // add the dz-success class (the green tick sign)
      $(file.previewElement).addClass("dz-success");
    },
    //when the remove button is clicked
    removedfile: function(file){
      // grap the id of the uploaded file we set earlier
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');

      // make a DELETE ajax request to delete the file
      $.ajax({
        type: 'delete',
        url: '/users/delete_avatar',
        success: function(data){
          $(".dz-image-preview").html("");
          //TODO add missing file
          $(".img-circle").attr("src", 'nil');
          console.log(data.message);
        }
      });
    }
  });

  if ($('#media-dropzone').length > 0) {
    $(function() {
      var mediaDropzone;
      mediaDropzone = new Dropzone("#media-dropzone", {
        paramName: "asset[image]"
      });
      var my_token = $('#my_unit_token').val();
      mediaDropzone.on("sending", function(file, xhr, data) {
        data.append("my_unit_token", my_token);
      });

      return mediaDropzone.on("success", function(file, response, data) {
        console.log(response);
        var _this = this;
        appendContent(response.url, response.id);
        setTimeout(function(){
          $('#myModal').modal('hide');
          _this.removeAllFiles();
        },1000);
      });
    });

    var appendContent = function(imageUrl, mediaId) {
      $(".carousel-inner").append('<div class="carousel_slider item">' +
        '<img src="' + imageUrl + '"/>' +
        '<a data-method="delete" data-remote="true" href="/pictures/' + mediaId + '">' + "Remove file" + '</a>' +
        '</div>');
      $("#delete").removeAttr('disabled');
      $("#no-media").html("");
    };
  };
});

var appendContent = function(imageUrl, mediaId) {
  $(".img-circle").attr("src", imageUrl);
};
