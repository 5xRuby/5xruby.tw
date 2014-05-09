$(document).on 'ready page:change', () ->
  $('.redactor').redactor
    imageUpload: '/redactor_images',
    imageUploadParam: 'redactor_image[image]',
    lang: 'zh_tw'
    uploadFields:
      'authenticity_token': $('meta[name="csrf-token"]').attr('content')