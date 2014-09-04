$(document).on 'ready page:change', () ->
  $('.datetimepicker').datetimepicker()
$(document).on 'nested:fieldAdded:stages', (event) ->
  event.field.find('.datetimepicker').datetimepicker()