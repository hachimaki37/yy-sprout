class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def admin_user?
    user_signed_in? && current_user.admin?
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :nickname ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end
end
