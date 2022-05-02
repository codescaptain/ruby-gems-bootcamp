class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit::Authorization

  after_action :user_activity

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pagy::Backend

  include PublicActivity::StoreController #save current_user using gem public_activity

  before_action :set_global_variables, if: :user_signed_in?

  def set_global_variables
    @ransack_courses = Course.ransack(params[:courses_search], search_key: :courses_search) #navbar search
  end

  private

  def user_activity
    current_user.try :touch
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_back(fallback_location: root_path)
  end

  before_action :set_locale
  private
  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end
  def extract_locale
    parsed_locale = params[:locale]
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end
end