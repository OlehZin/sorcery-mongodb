class ArticlesController < ApplicationController
  before_action :require_login

  def index
    @articles = Article.all
  end

  # /news/1 GET
  def show
    @article = resource
    unless @article
      render plain: "Page not found", status: 404
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
    @article =  resource
    if @article.update(article_params)
      flash[:success] = "Updated!"
      redirect_to action: "show"
    else
      flash.now[:error] = "Incorrect!!"
      render "edit"
    end
  end

  # /news/1 DELETE
  def destroy
    @article = resource
    @article.destroy
    flash[:success] = "Deleted!"
    redirect_to action: "index"
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def resource
    Article.find(params[:id])
  end

end
