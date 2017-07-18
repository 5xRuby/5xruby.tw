module Users
  module Profile
    class PasswordsController < ApplicationController
      def edit
        load_resource
      end

      def update
        load_resource
        save_resource
      end

      private

      def load_resource
        @resource ||= current_user
      end

      def save_resource
        if @resource.update_with_password(allowed_params)
          bypass_sign_in(@resource)
          redirect_to root_path, flash: { notice: I18n.t("devise.passwords.updated") }
        else
          render :edit
        end
      end

      def allowed_params
        params.require(:user).permit(:password, :password_confirmation, :current_password)
      end
    end
  end
end
