class ArticlesController < ApplicationController
  def index
    @articles = Article.published
  end

  # /news/1 GET
  def show
    @article = resource
    unless @article
      redirect_to root_path
    end
  end

  # /news/new GET
  def new
    @article = Article.new
  end

  # /news/1/edit GET
  def edit
    @article = resource
  end

  # /news POST
  def create
    @article = current_user.articles.new(article_params)
    if @article.save
      redirect_to articles_path, id: @article.id, notice: "Created!"
    else
      flash[:error] = "Incorrect!"
      render "new"
    end
  end

  # /news/1 PUT
  def update
    @article = resource
    if @article.update(article_params)
      redirect_to article_path, notice: "Updated!"
    else
      flash.now[:error] = "Incorrect!!"
      render "edit"
    end
  end

  # /news/1 DELETE
  def destroy
    @article = resource
    @article.destroy
    redirect_to articles_path, notice: "Deleted!"
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :title_image, :remove_title_image)
  end

  def resource
    Article.published.find(params[:id])
  end
end
