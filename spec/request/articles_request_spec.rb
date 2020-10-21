require 'rails_helper'
RSpec.describe "Articles", type: :request do
  let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678', password_confirmation: '12345678') }
  let!(:article) { create(:article, user: user) }

  before(:each) do
    login_user("bios111@gmail.com", "12345678")
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
    it "new article" do
      get new_article_path
      expect(response).to render_template(:new)
    end

    it "creates an article" do
      post articles_path, params: { article: {title: "Latest news", body: "Today...tralala"} }
      expect(response).to redirect_to articles_path
      follow_redirect!
      expect(response).to render_template(:index)
    end

    it "doesn't creates an article" do
      post articles_path, params: { article: {title: "", body: ""} }
      expect(response).to render_template(:new)
    end
  end

  describe "#update" do
    it "edit article" do
      get edit_article_path(article)
      expect(response).to render_template(:edit)
    end

    it "updates an article" do
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
    expect {
        delete article_path(article)
      }.to change{Article.count}.by(-1)
    expect(response).to redirect_to action: "index"
    follow_redirect!
    expect(response).to render_template(:index)
  end
end
