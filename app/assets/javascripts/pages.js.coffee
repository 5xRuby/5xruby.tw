$ () ->
  update_ntd = () ->
    $('#ntd').val(Math.round($('#contact_price').val() * 100000))
  update_contact_price = () ->
    $('#contact_price').val(parseFloat($('#ntd').val()) / 100000.0)
  $('#contact_price').change(update_ntd).keyup(update_ntd)
  $('#ntd').change(update_contact_price).keyup(update_contact_price)