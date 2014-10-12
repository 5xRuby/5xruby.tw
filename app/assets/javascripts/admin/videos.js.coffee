APP['admin/videos'] =
  _form: () ->
    $('#admin_video_summary').keydown (e) -> $('#summary_remain').text(150 - this.value.length)
    .keydown()