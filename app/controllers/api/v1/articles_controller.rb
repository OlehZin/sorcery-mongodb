class Api::V1::ArticlesController <  ApiController

  def index
    @articles = Article.published
  end

  def show
    @article = resource
    unless @article
      render plain: "Page not found", status: 404
    end
  end

  private

  def resource
    Article.published.find(params[:id])
  end
end
