module Users
  class AttendancesController < ApplicationController
    def new
      load_survey
    end

    def create
      load_survey
      save_survey
    end

    private

    def load_survey
      return redirect_to root_path, flash: { alert: t('errors.messages.not_valid_process') } if current_order.nil?
      @survey = DynamicFormForSurveyService.create(current_order)
    end

    def save_survey
      @survey.assign_attributes(allowed_params)
      if @survey.save
        redirect_to root_path
      else
        render :new
      end
    end

    def allowed_params
      params.require(:dynamic_survey).permit(*whitelisted, :activity_id)
    end

    def whitelisted
      current_order.questions.map do |key, value|
        if value[:as] != 'check_boxes'
          value[:name].to_sym
        else
          { value[:name].to_sym => [] }
        end
      end
    end

    def current_order
      @order ||= current_user.orders.find_by(serial: params[:serial]) || current_user.orders.pending.last
    end
  end
end
