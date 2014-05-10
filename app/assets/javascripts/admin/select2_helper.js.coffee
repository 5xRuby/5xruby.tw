$(document).on 'ready page:change', () ->
  $('.select2').select2
    width: '100%'
  $('.select2-single').select2
    width: '100%'
    initSelection: (element, callback) ->
      callback
        id: element.val()
        text: element.data('text')
    ajax:
      url: '/select2/results'
      dataType: 'json'
      data: (term, page) ->
        term: term
        page: page
        model: $(this).data('model')
        column: $(this).data('column')
      results: (data, page) -> data
  $('.select2-multiple').select2
    multiple: true
    width: '100%'
    initSelection: (element, callback) ->
      $(element).val('')
      callback $(element).data('init')
    ajax:
      url: '/select2/results'
      dataType: 'json'
      data: (term, page) ->
        term: term
        page: page
        model: $(this).data('model')
        column: $(this).data('column')
      results: (data, page) ->
        data
  $('.select2-tags-array').select2
    tags: []
    width: '100%'
    initSelection: (element, callback) ->
      $(element).val('')
      callback $(element).data('init').map (value) ->
        id: value, text: value
    createSearchChoice: (term) ->
      id: term, text: term
  $('.select2-tags').select2
    multiple: true
    width: '100%'
    initSelection: (element, callback) ->
      callback $.map(element.val().split(/[ ,]+/), (value) -> id: value, text: value)
    createSearchChoice: (term) ->
      id: term, text: term
    ajax:
      url: '/select2/tags'
      dataType: 'json'
      data: (term, page) ->
        term: term
        page: page
        context: $(this).data('context')
      results: (data, page) -> data
  $('.select2-polymorphic').change (e) ->
    model_name = $(this).val()
    column_name = $(this).data('models')[model_name]
    target = $(this).data('target') || '#' + this.id.replace('_type', '_id')
    $(target).select2
      width: '100%'
      initSelection: (element, callback) ->
        callback
          id: element.val()
          text: element.data('text')
      ajax:
        url: '/select2/results'
        dataType: 'json'
        data: (term, page) ->
          term: term
          page: page
          model: model_name
          column: column_name
        results: (data, page) -> data
  $('.select2-polymorphic').trigger('change')