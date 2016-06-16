$(document).ready(function() {
  var offset = $('.promos').offset().top;
  $.fn.followTo = function (pos) {
    var $this = this,
    $window = $(window);

    $window.scroll(function (e) {
      if ($window.scrollTop() >= pos) {
        $this.css({
          position: 'absolute',
          top: pos
        });
      } else {
        $this.css({
          position: 'fixed',
          top: offset
        });
      }
    });
  };
  $('.promos').followTo($('#left-column').outerHeight(true) - $('.promos').outerHeight(true));
});
