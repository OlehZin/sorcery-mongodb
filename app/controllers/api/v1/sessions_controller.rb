class Api::V1::SessionsController < ApiController
 skip_before_action :authenticate_request

 def authenticate
   if @user = login(user_params[:email], user_params[:password])
     render json: { token: JsonWebToken.encode(user: @user.id) }
   else
     render json: {error: "Invalid email or password"}
   end
 end

   private

   def user_params
     params.require(:user).permit(:email, :password)
   end
end
