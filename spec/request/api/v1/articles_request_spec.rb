require 'rails_helper'

RSpec.describe Api::V1::ArticlesController, type: :request do
  let!(:articles) { create_list(:article, 10) }

  it "get index" do
    get api_v1_articles_path
    expect(response).to be_successful
    expect(json).not_to be_empty
  end

  it "get show" do
    get api_v1_articles_path(@article)
    expect(response).to be_successful
    expect(json).not_to be_empty
  end
end
