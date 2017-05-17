#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require gistyle
#
#= require jquery-ui
#= require jquery_nested_form
#= require select2
#= require select2_helper
#= require handlebars
#= require jquery-fileupload/basic
#= require ace-rails-ap
#
#= require highlightjs
#= require admin/moment.min
#= require admin/bootstrap-datetimepicker.min
#= require admin/redactor
#= require admin/redactor_zh_tw
#= require admin/bootstrap-markdown
#= require admin/markdown
#= require admin/to-markdown
#= require admin/jsoneditor
#
#= require shared
#
#= require_tree ./admin
#
#= require react
#= require react_ujs
#= require_tree ./admin_components

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
