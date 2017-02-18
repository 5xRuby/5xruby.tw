$ () ->
  update_ntd = () ->
    $('#ntd').val(Math.round($('#mmm').val() * 100000))
  update_mmm = () ->
    $('#mmm').val(parseFloat($('#ntd').val()) / 100000.0)
  $('#mmm').change(update_ntd).keyup(update_ntd)
  $('#ntd').change(update_mmm).keyup(update_mmm)
  
  $("a").focus ->
    $(this).blur()

  $(window).scroll ->
    if ($(this).scrollTop() > 100)
      $('.scrollup').fadeIn()
    else
      $('.scrollup').fadeOut()

    $('.scrollup').click ->
      $("html, body").animate(
        scrollTop: 0
        , 600)
      false


  if $('.swiper-container').length
    swiper = new Swiper('.swiper-container',
      pagination: '.swiper-pagination',
      nextButton: '.swiper-button-next',
      prevButton: '.swiper-button-prev',
      slidesPerView: 1,
      paginationClickable: true,
      spaceBetween: 0,
      loop: true
    )
  
  $('.openable').each((i, openable) ->
    $(openable).click( ->
      $(this).find(
        $(this).data('target')
      ).slideToggle()
    )
  )
