require 'rails_helper'

RSpec.describe "Articles", type: :request do
  let!(:user) { FactoryBot.create(:user) }
  #let!(:article) { Article.create(title: "News", body: "Some text")}
  let!(:article) { FactoryBot.create(:article, user: user) }

  before(:each) do
      @user = create(:user)
      login_user
    end

  it "get index" do
    get articles_path
    expect(response).to be_successful
  end

  it "get show" do
    get article_path(article)
  expect(response).to be_successful
  end

  describe "#create" do
    it "creates an article" do
      get new_article_path
      expect(response).to render_template(:new)
      post articles_path(@article), params: { article: {title: "Latest news", body: "Today...tralala"} }
      expect(response).to redirect_to articles_path
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it "doesn't creates an article" do
      get new_article_path
      expect(response).to render_template(:new)
      post articles_path, params: { article: {title: "", body: ""} }
      expect(response).to render_template(:new)
    end
  end

  describe "#create" do
    it "updates an article" do
      get edit_article_path(article)
      expect(response).to render_template(:edit)
      put article_path(article), params: { article: {title: "Latest news", body: "some text"}}
      expect(response).to redirect_to action: "show"
      follow_redirect!
      expect(response).to render_template(:show)
    end

    it "doesn't updates an article" do
      get edit_article_path(article)
      expect(response).to render_template(:edit)
      put article_path(article), params: { article: {title: "", body: ""} }
      expect(response).to render_template(:edit)
    end
  end

  it "deletes an article" do
    get articles_path
    delete article_path(article)
    expect(response).to redirect_to action: "index"
    follow_redirect!
    expect(response).to render_template(:index)
  end
end
