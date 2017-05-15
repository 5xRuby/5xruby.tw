$(document).ready ->

  # ace editor
  bind_textarea = (session, textarea) ->
    session.on 'change', () -> textarea.val(session.getValue())
  for dom in $('.aceditor')
    editor = ace.edit(dom)
    session = editor.getSession()
    textarea = $(dom.dataset.bind)
    editor.setTheme("ace/theme/tomorrow_night_bright")
    editor.setFontSize(16)
    session.setMode("ace/mode/markdown")
    session.setUseWrapMode(true)
    session.setTabSize(2)
    session.setValue(textarea.val())
    bind_textarea session, textarea
  
  # jsoneditor
  for dom in $('.jsoneditor-input')
    ((input) ->
      container = $('<div></div>')
      init_value = JSON.parse input.val()
      input.after(container)
      editor = new JSONEditor(container.get()[0], {
        modes: ['tree', 'code']
      }, init_value)
      input.parents('form').eq(0).submit( ->
        input.val JSON.stringify(editor.get())
      )
      input.hide()
      editor.expandAll()
    )($(dom))
  
  # redactor
  redactor_options =
    buttonSource: true
    imageUpload: '/redactor_images'
    imageUploadParam: 'redactor_image[image]'
    lang: 'zh_tw'
    uploadImageFields:
      'authenticity_token': $('meta[name="csrf-token"]').attr('content')

  $(document).on 'ready page:change', () ->
    $('.redactor').redactor redactor_options

  $(document).on 'nested:fieldAdded', (e) ->
    e.field.find('.redactor').redactor redactor_options
