class ArticlesController < ApplicationController
  before_action :require_login

  def index
    @articles = Article.all
  end

  # /news/1 GET
  def show
    resource
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
    resource
  end

  # /news POST
  def create
    @article = Article.create(article_params)
    if @article.errors.empty?
      flash[:success] = "Created!"
      redirect_to articles_path
    else
      flash.now[:error] = "Incorrect!"
      render "new"
    end
  end

  # /news/1 PUT
  def update
    resource
    @article.update_attributes(article_params)
      if @article.errors.empty?
        flash[:success] = "Updated!"
        redirect_to action: "show"
      else
        flash.now[:error] = "Incorrect!"
        render "edit"
      end
  end

  # /news/1 DELETE
  def destroy
    resource
    @article.destroy
    flash[:success] = "Deleted!"
    redirect_to action: "index"
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end

  def resource
    @article = Article.find(params[:id])
  end

end
