require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { create(:user) }

  describe "model tests" do
    it "have valid factory" do
      expect(user).to be_valid
    end
  end
end
