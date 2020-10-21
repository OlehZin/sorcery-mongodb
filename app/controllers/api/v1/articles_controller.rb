class Api::V1::ArticlesController <  ApiController

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
