$ () ->
  redactor_options =
    imageUpload: '/redactor_images'
    imageUploadParam: 'redactor_image[image]'
    lang: 'zh_tw'
    uploadImageFields:
      'authenticity_token': $('meta[name="csrf-token"]').attr('content')

  $(document).on 'ready page:change', () ->
    $('.redactor').redactor redactor_options

  $(document).on 'nested:fieldAdded', (e) ->
    e.field.find('.redactor').redactor redactor_options