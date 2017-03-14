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
      $('.scrollup').removeClass 'scrollup-hide'
      $('.navbar').addClass 'resized'
      $('.navbar-brand').addClass 'goup'
      $('#lang-sign-in').fadeOut 'fast'
    else
      $('.scrollup').addClass 'scrollup-hide'
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
  
  for swiper_container in $('.swiper-container')
    $swiper_container = $(swiper_container)
    new Swiper(swiper_container,
      pagination: $swiper_container.find('.swiper-pagination').get()[0],
      slidesPerView: $swiper_container.data('slides-per-view') || 1,
      paginationClickable: $swiper_container.data('disable-pagination-clickable') == undefined,
      spaceBetween: $swiper_container.data('space-between') || 0,
      loop: $swiper_container.data('disable-loop') == undefined,
      autoplay: $swiper_container.data('autoplay')
    )

  $('.openable').each((i, openable) ->
    $(openable).click( ->
      $(this).find(
        $(this).data('target')
      ).toggleClass('opened')
    )
  )

  vex.defaultOptions.className = 'vex-theme-plain'
  $('.vex-dialog-opener').each (i, opener) ->
    $(opener).click ->
      vex.dialog.alert
        message: $($(this).data('target')).html()
      setTimeout ->
        $('.vex').scrollTo(0, 600, {interrupt: true})
      , 300

  $('.dropdown-toggle').dropdown()

  $('.text-overflow-auto-scroll').mousemove (e) ->
    scroll_frame = $(this)
    offset = scroll_frame.offset()
    scroll_frame.clearQueue().scrollTo(
      {
        top: "#{(e.pageY - offset.top) * 100 / scroll_frame.height()}%",
        left: "#{(e.pageX - offset.left) * 100 / scroll_frame.height()}%"
      },
      10, {interrupt: true})

