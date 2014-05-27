$(document).on 'ready page:change', () ->
  if $('body').data('controller') == 'admin/schedules' && $('form').length > 0
    $('#course').on 'change', (e) ->
      course_id = this.value
      $('#admin_schedule_stage_id').select2
        width: '100%'
        initSelection: (element, callback) ->
          callback
            id: element.val()
            text: element.data('text')
          element.data('text', '')
        ajax:
          url: '/select2/results'
          dataType: 'json'
          data: (term, page) ->
            term: term
            page: page
            where: {course_id: course_id}
            model: 'Stage'
            column: 'title'
          results: (data, page) -> data
    .trigger('change')

$(document).on 'nested:fieldAdded:events', (e) ->
  e.field.find('input[name$="[speaker_id]"]').select2_single()