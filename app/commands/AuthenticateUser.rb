require 'jwt'
class AuthenticateUser
  prepend SimpleCommand

  attr_reader :email, :password

  def initialize(user_params)
    #binding.pry
    @email = user_params[:email]
    @password = user_params[:password]
  end

  def call
  #  binding.pry
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user

    user = User.where({email: email})
    binding.pry
    return user if user && user.authenticate(email, password)
    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end
