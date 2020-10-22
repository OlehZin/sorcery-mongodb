require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :request do
  let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678', password_confirmation: '12345678') }
  let!(:articles) { create_list(:article, 10) }
  let!(:article) { create(:article, :published) }
  let!(:user_token) { JsonWebToken.encode(user_id: user.id) }
  let!(:headers) { {'Authentication': user_token} }

  it "get index" do
    get api_v1_articles_path, headers: headers
    expect(response).to be_successful
    expect(json).not_to be_empty
  end

  it "get show" do
    get api_v1_article_path(Article.published.first), headers: headers
    expect(response).to be_successful
    expect(json).not_to be_empty
  end
end
