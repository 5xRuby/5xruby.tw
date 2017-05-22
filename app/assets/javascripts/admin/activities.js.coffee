$(document).ready ->
  class ActivityForm
    constructor: ->
      @$typeInput = $("select[name='admin_activity[type]']")
      @.bindInput(@$typeInput)
      @.setupTrigger()

    bindInput: (input)->
      if input.val() == "Activity::Camp"
        for el in $('.camp_only')
          $(el).show()
      else
        for el in $('.camp_only')
          $(el).hide()

    setupTrigger: ->
      @$typeInput.on 'change', (e)=>
        @bindInput($(e.target))

  activityForm = new ActivityForm
