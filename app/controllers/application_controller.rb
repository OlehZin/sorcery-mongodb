class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = 'First log in, please)'
    redirect_to main_app.login_path
    #redirect_to '/login'
  end
end
