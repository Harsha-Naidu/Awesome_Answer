class ApplicationController < ActionController::Base
    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method(:current_user)
    # The method 'helper_method' is to explicitly share some methods defined in the controller to make them available for the views. This is used for any method that you need to access from both controllers and views.

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def authenticate_user!
        redirect_to new_session_path, alert: 'Please sign in' unless user_signed_in?
    end

end
