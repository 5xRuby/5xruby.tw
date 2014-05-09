$(document).on 'ready page:change', () ->
  $('.redactor').redactor
    imageUpload: '/images'
    imageUploadParam: 'image[image]'
    lang: 'zh_tw'