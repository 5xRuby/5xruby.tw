module DynamicFormForSurveyService
  class Builder
    def initialize(activity)
      @activity = activity

      @klass = Class.new(ActiveType::Record[Order]) do
        attr_accessor :questions

        def self.model_name
          ActiveModel::Name.new(self, nil, "dynamic_survey")
        end
      end
    end

    def generate
      @survey = @klass.new
      @survey.questions = @activity.survey.questions
      @survey.activity = @activity
      @survey.questions.each do |key, value|
        @survey.class.class_eval do
          # set attribute_accessors
          attribute value[:name].to_sym

          # set callbacks
          before_validation do
            self.send("#{value[:name]}=", (self.send(value[:name]) || []) & value[:collection])
          end if value[:as] == 'check_boxes'

          # set validations
          validates value[:name].to_sym, presence: true if value[:required]
          validates value[:name].to_sym, inclusion: { in: value[:collection] } if %w[check_boxes radio_buttons select].include?(value[:as])
          validates value[:name].to_sym, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ , message: I18n.t('errors.messages.not_correct_email_format') } if %w[email].include?(value[:as])
        end
      end

      @survey
    end
  end

  def self.create(resource)
    Builder.new(resource).generate
  end
end
