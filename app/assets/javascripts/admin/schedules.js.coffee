$(document).on 'nested:fieldAdded:events', (e) ->
  e.field.find('input[name$="[speaker_id]"]').select2_single()