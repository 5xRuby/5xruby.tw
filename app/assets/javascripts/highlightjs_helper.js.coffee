$(document).on 'ready page:change', () ->
  hljs.highlightBlock(e) for e in $('.highlight pre code')