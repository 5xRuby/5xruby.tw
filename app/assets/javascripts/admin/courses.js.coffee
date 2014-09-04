APP['admin/courses'] =
  _form: () ->
    $('#admin_course_summary').keydown (e) -> $('#summary_remain').text(150 - this.value.length)
    .keydown()