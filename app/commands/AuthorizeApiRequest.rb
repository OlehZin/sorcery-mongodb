require 'jwt'
class AuthorizeApiRequest
  prepend SimpleCommand
  #тут параметри беруться, коли викликається команд
  def initialize(headers = {})
    @headers = headers['Authentication']
  end
  #тут повертається результат
  def call
    fetch_user
  end

  private

  attr_reader :headers
  #метод, який шукає користувача
  def fetch_user
    @user = User.find(decode_auth_token["user_id".to_sym]) if decode_auth_token
    return nil unless @user.present?
    @user
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
