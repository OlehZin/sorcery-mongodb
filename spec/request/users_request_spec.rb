require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:user) { create(:user) }

  describe "#create" do
    it "new user" do
      get new_user_path
      expect(response).to render_template(:new)
    end

    it "creates a user" do
      post users_path, params: { user: {email: 'bios@gmail.com', password: '12345678', password_confirmation: '12345678' } }
      expect(response).to redirect_to articles_path
      follow_redirect!
      expect(response).to render_template(:index)
      end

    it "doesn't creates a user" do
      post users_path, params: { user: {email: '', password: '', password_confirmation: '' } }
      expect(response).to render_template(:new)
    end
  end

  describe "#activate" do
    it "activated a user" do
      get activate_user_path(user.id)
      expect(response).to have_http_status(302)
    end
  end
end
