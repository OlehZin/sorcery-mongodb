require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user, email: "someuser@mail.com") }
  let!(:article) { create(:article, user: user) }

  describe "model tests" do
    it "have valid factory" do
      expect(article).to be_valid
    end
  end

  describe "article user_email" do
    it "shows email" do
      expect(article.user_email).to eq "someuser@mail.com"
    end
  end
end
