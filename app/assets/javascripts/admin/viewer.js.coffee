# json formatter
$(document).ready ->
  class CampTemplateViewer
    constructor: ->
      @$viewer = $('.json_viewer')
      @renderData()

    renderData: ->
      if @$viewer.length
        init_value = JSON.parse @$viewer.text()
        @$viewer.empty()
        @$viewer.jsonViewer(init_value, {collapsed: false, withQuotes: false})

  campTemplateViewer = new CampTemplateViewer
