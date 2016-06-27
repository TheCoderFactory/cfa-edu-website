$(document).ready(function() {
  $('#myModal').on('hidden.bs.modal', function(e){
    var src = $(this).find('iframe').attr('src');
    $(this).find('iframe').attr('src', '');
    $(this).find('iframe').attr('src', src);
  });
});
