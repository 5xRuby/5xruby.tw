$(document).ready ->
  if $('.show-post').length > 0
    if $('.show-post').data('post-mark-type') == 'markdown'
      html_content = markdown.toHTML($('.show-post').html())
      $('.show-post').html html_content
