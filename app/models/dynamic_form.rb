module DynamicForm
  class Builder
    def initialize(activity)
      @activity = activity

      @klass = Class.new(ActiveType::Record[Order]) do
        attr_accessor :questions

        def self.model_name
          ActiveModel::Name.new(self, nil, "dynamic_form")
        end
      end
    end

    def generate
      @form = @klass.new
      @form.questions = JSON.parse(@activity.form.fields).map(&:symbolize_keys)
      @form.purchasable = @activity
      @form.questions.each do |q|
        @form.class.class_eval do
          # set attribute_accessors
          attribute q[:name].to_sym

          # set callbacks
          before_validation do
            self.send("#{q[:name]}=", self.send(q[:name]) & q[:collection])
          end if q[:as] == 'check_boxes'

          # set validations
          validates q[:name].to_sym, presence: true if q[:required]
          validates q[:name].to_sym, inclusion: { in: q[:collection] } if %w[radio_buttons select].include?(q[:as])
          validates q[:name].to_sym, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/ , message: I18n.t('errors.messages.not_correct_email_format') } if %w[email].include?(q[:as])
        end
      end
      @form
    end
  end

  def self.create(resource)
    Builder.new(resource).generate
  end
end
