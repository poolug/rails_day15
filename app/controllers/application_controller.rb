class ApplicationController < ActionController::Base
    before_action :banned?
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def banned?
        if current_user.present? && current_user.banned?
            sign_out current_user
            flash[:notice] = "¡Tu cuenta está banneada!"
            redirect_to root_path
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :photo])
        devise_parameter_sanitizer.permit(:update, keys: [:name, :photo])
    end

end
