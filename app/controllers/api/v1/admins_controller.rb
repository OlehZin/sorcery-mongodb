class Api::V1::AdminsController < ApiController

 def activate
    user = User.find(params[:user_id])
    if current_user.admin?
      user.activate_account!
      redirect_to api_v1_users_path
    else
      redirect_to :back
    end
  end
end
