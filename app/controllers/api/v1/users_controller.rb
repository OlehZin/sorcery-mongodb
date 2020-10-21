class Api::V1::UsersController <  ApiController

  def index
    @users = User.all
  end

  def show
    @user = resource
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user }
    else
      render json: {error: "Invalid email or password"}
    end
  end

  private

  def resource
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
