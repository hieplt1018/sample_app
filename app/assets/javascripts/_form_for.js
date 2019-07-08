$('#micropost_picture').bind('change', function() {
  var size_in_megabytes = this.files[0].size/Settings.bit_image/Settings.bit_image;
  if (size_in_megabytes > Settings.image_size) {
    alert(I18n.t('file_js');
  }
});
