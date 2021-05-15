$(function(){
  $(document).on('turbolinks:load', function(){
    $('.navbar-toggler').click(function(){
      $('#navbarToggleDemo01').toggleClass('close');
    });
  });
});
