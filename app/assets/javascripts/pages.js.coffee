$ () ->
  update_ntd = () ->
    $('#ntd').val(Math.round($('#contact_price').val() * 100000))
  $('#contact_price').change(update_ntd).keyup(update_ntd)