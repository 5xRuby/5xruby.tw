$ () ->
  update_ntd = () ->
    $('#ntd').val(Math.round($('#mmm').val() * 100000))
  update_mmm = () ->
    $('#mmm').val(parseFloat($('#ntd').val()) / 100000.0)
  $('#mmm').change(update_ntd).keyup(update_ntd)
  $('#ntd').change(update_mmm).keyup(update_mmm)