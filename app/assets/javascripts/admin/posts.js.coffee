$(document).ready ->
  $('#redactor_image_image').fileupload
    type: "post"
    dataType: "json"

  $('.markdown-editor').markdown
    additionalButtons:[[{
      name: "upload"
      data:[{
        name: "cmdUpload"
        icon: "glyphicon glyphicon-upload"
        toggle: false
        title: "Upload Image"
        callback: (e) ->
          selected = e.getSelection()
          st = selected.start
          $('#redactor_image_image').fileupload
            done: (fe,d) ->
              e.replaceSelection "![](#{d.result.filelink})"
              e.setSelection st+2, st+2
          $('#redactor_image_image').trigger('click')
      }]
    }]]
  set_editor = (it) ->
    $('.content-editor').hide()
    $(".admin_post_content_#{it}").show()
  if $('.post-form').length > 0
    $("[name='admin_post[markup_type]']").on 'click', (e) ->
      set_editor($(e.target).val())
    set_editor($("[name='admin_post[markup_type]']").val())
