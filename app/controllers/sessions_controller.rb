class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
  end

  def create
    if login(params[:email], params[:password], params[:remember_me])
          flash[:success] = "Logged in!"
          redirect_back_or_to articles_path
        else
          flash.now[:warning] = 'E-mail and/or password is incorrect.'
          render 'new'
        end
      end

  def destroy
    logout
    flash[:success] = 'See you!'
    redirect_to root_path
  end
end
