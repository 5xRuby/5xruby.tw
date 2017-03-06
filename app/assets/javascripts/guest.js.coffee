$ () ->
  update_ntd = () ->
    $('#ntd').val(Math.round($('#mmm').val() * 100000))
  update_mmm = () ->
    $('#mmm').val(parseFloat($('#ntd').val()) / 100000.0)
  $('#mmm').change(update_ntd).keyup(update_ntd)
  $('#ntd').change(update_mmm).keyup(update_mmm)

  $("a").focus ->
    $(this).blur()

  scroll_window = (target, onAfter = (->), duration = 500) ->
    $(window).scrollTo(target, duration, {interrupt: true, onAfter: onAfter})

  $('.scrollup').click ->
    scroll_window 0

  $(window).scroll ->
    if ($(this).scrollTop() > 100)
      $('.scrollup').fadeIn()
      $('.navbar').addClass 'resized'
      $('.navbar-brand').addClass 'goup'
      $('#lang-sign-in').fadeOut 'fast'
    else
      $('.scrollup').fadeOut()
      $('.navbar').removeClass 'resized'
      $('.navbar-brand').removeClass 'goup'
      $('#lang-sign-in').fadeIn 'fast'

  $('a').click (e) ->
    anchor = $(this).attr('href')
    if anchor and anchor.startsWith("#")
      if $(anchor).length
        scroll_window $(anchor), ->
          location.hash = anchor
      e.preventDefault
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

  vex.defaultOptions.className = 'vex-theme-plain';
  $('.vex-dialog-opener').each (i, opener) ->
    $(opener).click ->
      vex.dialog.alert
        message: $($(this).data('target')).html()
      setTimeout ->
        $('.vex').scrollTo(0, 600, {interrupt: true})
      , 300

  $('.dropdown-toggle').dropdown()

