$(document).ready ->
  class ActivityForm
    constructor: ->
      @$activityTypeInput = $("select[name='admin_activity[type]']")
      @$templateInputGroup = $(".admin_activity_template")
      @$activityTemplateInput = @$templateInputGroup.find("select")
      @.bindTemplateInput(@$activityTypeInput)
      @.setupTrigger()

    bindTemplateInput: (input)->
      if input.val() == "Activity::Camp"
        @$templateInputGroup.show()
      else
        @$activityTemplateInput.val("")
        @$templateInputGroup.hide()

    setupTrigger: ->
      @$activityTypeInput.on 'change', (e)=>
        @bindTemplateInput($(e.target))

  activityForm = new ActivityForm
