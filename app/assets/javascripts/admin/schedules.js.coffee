$(document).on 'ready page:change', () ->
  if $('body').data('controller') == 'admin/schedules' && $('form').length > 0
    $('#course').on 'change', (e) ->
      course_id = this.value
      $('#admin_schedule_stage_id').select2_single
        ajax:
          data: (term, page) ->
            term: term
            page: page
            where: {course_id: course_id}
            model: 'Stage'
            column: 'title'
    .trigger('change')

$(document).on 'nested:fieldAdded:events', (e) ->
  e.field.find('input[name$="[speaker_id]"]').select2_single()