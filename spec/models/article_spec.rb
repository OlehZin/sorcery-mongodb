require 'rails_helper'

RSpec.describe Article, type: :model do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }

  describe "model tests" do
    it "have valid factory" do
      expect(article).to be_valid
    end
  end
end
