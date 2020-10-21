class ApiController < ActionController::API
  include Sorcery::Controller
  before_action :authenticate_request
  attr_reader :current_user
  #Виклик AuthorizeApiRequest надходить з модуля SimpleCommand, де він
  #визначається як attr_reader: result. Результати запиту повертаються до
  #@current_user, таким чином стаючи доступними для всіх контролерів, що успадковуються від ApiController.
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { errors: [{ code: 401, message: 'Not Authorized' }] },
      status: 401 unless @current_user
  end

  def form_authenticity_token; end
end
