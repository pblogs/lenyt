/*
$(function() {
  var myDropzone;
  myDropzone = new Dropzone("#edit_user");
  return myDropzone.on("success", function(file, responseText) {
    var _this = this;
    appendContent(responseText.file_name.url, responseText.id);
    setTimeout(function(){
      $('#uploadAvatar').modal('hide');
      _this.removeAllFiles();
    },1000);
  });
});


*/

$(document).ready(function(){
  // disable auto discover
  Dropzone.autoDiscover = false;

  // grap our upload form by its id
  $("#new_form").dropzone({
    url: '/users/upload_avatar',
    method: 'put',
    maxFiles: 1,
    // restrict image size to a maximum 1MB
    maxFilesize: 1,
    uploadMultiple: false,
    // changed the passed param to one accepted by
    // our rails app
    paramName: "user[avatar]",
    // show remove links on each image upload
    addRemoveLinks: true,
    // if the upload was successful
    success: function(file, response){
      appendContent(response.file_name.url, response.id);
      // find the remove button link of the uploaded file and give it an id
      // based of the fileID response from the server
      $(file.previewTemplate).find('.dz-remove').attr('id', response.fileID);
      // add the dz-success class (the green tick sign)
      $(file.previewElement).addClass("dz-success");
    },
    //when the remove button is clicked
    removedfile: function(file){
      // grap the id of the uploaded file we set earlier
      var id = $(file.previewTemplate).find('.dz-remove').attr('id');

      // make a DELETE ajax request to delete the file
      $.ajax({
        type: 'DELETE',
        url: '/delete_avatar/' + id,
        success: function(data){
          console.log(data.message);
        }
      });
    }
  });
});

var appendContent = function(imageUrl, mediaId) {
  $(".img-content").append('<div class="col-lg-4">' +
    '<div class="thumbnail"><img src="' + imageUrl + '"/>' +
    '<div class="caption">' +
    '<input id="media_contents_" name="media_contents[]" value="' + mediaId +'" type="checkbox">' +
    '</div>' +
    '</div></div>');
  $("#delete").removeAttr('disabled');
  $("#no-media").html("");
};
