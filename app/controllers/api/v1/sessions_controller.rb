class Api::V1::SessionsController < ApiController
 skip_before_action :authenticate_request

 def authenticate
   #binding.pry
   command = AuthenticateUser.call(user_params)
   if command.success?
     render json: { auth_token: command.result }
   else
     render json: { error: command.errors }, status: :unauthorized
   end
 end

   private

   def user_params
     params.require(:user).permit(:email, :password)
   end
end




  # before_action :authorized, only: [:create]
  #
  # def create
  #   #binding.pry
  #   @user = User.find_by(email: params[:email])
  #   if @user && @user.authenticate(params[:password])
  #     token = encode_token({user_id: @user.id})
  #     render json: {user: @user, token: token}
  #   else
  #     render json: {error: "Invalid email or password"}
  #   end
  # end
  #
  # private
  #
  # def user_login_params
  #   params.require(:user).permit(:email, :password)
  # end
