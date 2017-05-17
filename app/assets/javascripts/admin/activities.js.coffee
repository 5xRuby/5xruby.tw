$(document).ready ->
  class ActivityForm
    constructor: ->
      @$typeInput = $("select[name='admin_activity[type]']")
      @$templateInputGroup = $(".admin_activity_template")
      @$templateInput = @$templateInputGroup.find("select")
      @$titleInputGroup = $(".admin_activity_title")
      @$titleInput = @$titleInputGroup.find("input")
      @.bindInput(@$typeInput)
      @.setupTrigger()

    bindInput: (input)->
      if input.val() == "Activity::Camp"
        @$templateInputGroup.show()
        @$titleInputGroup.show()
      else
        @$templateInput.val("")
        @$titleInput.val("")
        @$templateInputGroup.hide()
        @$titleInputGroup.hide()

    setupTrigger: ->
      @$typeInput.on 'change', (e)=>
        @bindInput($(e.target))

  activityForm = new ActivityForm
