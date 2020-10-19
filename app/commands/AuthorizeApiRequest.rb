require 'jwt'
class AuthorizeApiRequest
  prepend SimpleCommand
  #тут параметри беруться, коли викликається команд
  def initialize(headers = {})
    @headers = headers['Authentication']
  end
  #тут повертається результат
  def call
    user
  end

  private

  attr_reader :headers
  # шукаємо користувача або його немає
  def user
    @user ||= fetch_user
    return errors.add(:invalid, type: :token, error: :invalid) && nil unless @user
    # if !@user.is_an_admin? && @user.account_locked?
    #   errors.add(:account_locked, type: :resource, error: :account_locked)
    # else
    #   @user
    # end
  end
  #метод, який шукає користувача
  def fetch_user
    #binding.pry
    User.find(decode_auth_token["user_id".to_sym]) if decode_auth_token
  end
  #метод, який декодує токен, отриманий від http_auth_header і отримує user_id
  def decode_auth_token
    return unless http_auth_header
    begin
      @decode_auth_token ||= JsonWebToken.decode(http_auth_header)
    rescue
      false
    end
  end
  #витягує токен із хедера авторизації, отриманого при ініціалізації класу.
  def http_auth_header
    headers.split(' ').last if headers.present?
  end
end
