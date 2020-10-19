class Api::V1::ArticlesController <  ApiController
  before_action :authorized, only: [:auto_login]

  def index
    @articles = Article.all
  end

  def show
    @article = resource
  end

  private

  def resource
    Article.find(params[:id])
  end
end
