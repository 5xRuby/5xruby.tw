$(document).on 'ready page:change', () ->
  for element in $('.sortable')
    $(element).sortable
      items: element.getAttribute('data-items')
      update: () ->
        for field_id, i in $(element).sortable('toArray')
          $('#' + field_id).find('input[name$="[sort_id]"]').val(i)

$(document).on 'nested:fieldAdded', (e) ->
  e.field.attr('id', e.field.attr('id') + '_' + Date.now())
  for element in $('.sortable')
    for field_id, i in $(element).sortable('toArray')
      $('#' + field_id).find('input[name$="[sort_id]"]').val(i)