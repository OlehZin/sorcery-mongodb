class Api::V1::ArticlesController <  ApiController

  def index
    @articles = Article.published
  end

  def show
    @article = resource
    unless @article
      redirect_to :root
    end
  end

  private

  def resource
    Article.published.find(params[:id])
  end
end
