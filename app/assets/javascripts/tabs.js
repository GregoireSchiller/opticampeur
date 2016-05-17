$(function(){

  $(".tab").on("click", function(e){
    $(".tab").removeClass('active');
    $(this).toggleClass('active');
    // Change active tab

    $(".tab-content").addClass('hidden');


    // Hide all tab-content (use class="hidden")

    $($(this).data('target')).removeClass('hidden')
    // Show target tab-content (use class="hidden")
  });

});
