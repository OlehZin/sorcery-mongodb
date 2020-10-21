require 'rails_helper'

RSpec.describe "Users_sessions", type: :request do
  let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678',
      password_confirmation: '12345678') }

  describe "log_in" do
    it "get log_in" do
      get login_path
      expect(response).to be_successful
    end

    it "log_in user" do
      post sessions_path, params: {user: {email: user.email, password: "12345678"}}
      expect(response).to redirect_to articles_path
    end

    it "invalid log_in" do
      post sessions_path params: {user: {email: '', password: ''}}
      expect(response).to redirect_to login_path
    end
  end

  describe "log_out" do
    it "log_out " do
      delete log_out_path
      expect(response).to redirect_to login_path
    end
  end
end
