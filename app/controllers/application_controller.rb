class ApplicationController < ActionController::Base
  private
    def require_signin
      session[:prev_requested_url] = request.url
      unless current_user
        redirect_to signin_path, alert: "Please sign in first!"
      end
    end

    def current_user
      return unless session[:user_id] 
      @current_user ||= User.find(session[:user_id])
    end

    helper_method :current_user

    def current_user?(user)
      current_user == user
    end

    helper_method :current_user?

    def require_admin
      unless current_user_admin?
        redirect_to root_url, alert: "Unauthorized access!"
      end
    end
    
    def current_user_admin?
      current_user && current_user.admin?
    end

    helper_method :current_user_admin?
end
