#= require jquery
#= require jquery_ujs
#= require moment.min
#= require bootstrap
#= require bootstrap-datetimepicker.min
#= require jquery_nested_form
#= require jquery-ui
#= require redactor
#= require redactor_zh_tw
#= require select2
#= require select2_helper
#= require highlightjs
#= require highlightjs_helper
#= require gistyle
#= require handlebars
#= require bootstrap-markdown
#= require markdown
#= require to-markdown
#= require jquery-fileupload/basic
#= require_tree ./admin

APP['admin'] =
  space_price: () ->
    source   = $("#template_row").html()
    template = Handlebars.compile(source)
    $('#tbody').append(template({id: Date.now()}))
    $('#new_day_btn').click () ->
      row_html = $(template({id: Date.now()}))
      $('#tbody').append(row_html)
      row_html.find('.datetimepicker').datetimepicker()
      row_html.find('.delete_btn').click () ->
        $(this).closest('tr').remove()
    $('form').on 'ajax:success', (e, data) ->
      $('#result').html(data)
