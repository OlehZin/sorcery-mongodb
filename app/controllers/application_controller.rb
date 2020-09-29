class ApplicationController < ActionController::Base
  before_action :require_login

  private

  def not_authenticated
    flash[:warning] = 'First log in, please)'
    redirect_to '/login'
  end
end
