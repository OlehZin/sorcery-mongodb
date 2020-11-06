class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    if @user = login(params[:user][:email], params[:user][:password], params[:user][:remember_me])
      flash[:success] = "Logged in!"
      redirect_back_or_to articles_path
    else
      flash[:error] = 'E-mail and/or password is incorrect.'
      redirect_to login_path
    end
  end

  def destroy
    logout
    flash[:success] = 'See you!'
    redirect_to root_path
  end
end
