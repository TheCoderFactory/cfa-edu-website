$(document).ready(function(){
  $('#course-list-nav').scrollToFixed({
    marginTop: 150,
    limit: function() {
      var limit = $('.newsletter-subscribe').offset().top - $('#course-list-nav').outerHeight(true) - 35;
      return limit;
    },
    removeOffsets: true
  });
});
