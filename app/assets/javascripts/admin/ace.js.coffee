$ () ->
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