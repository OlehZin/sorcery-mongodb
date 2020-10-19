require 'rails_helper'
#require 'jwt'
RSpec.describe Api::V1::UsersController, type: :request do
  let!(:user) { create(:user) }
  #let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678',
        #password_confirmation: '12345678') }
  let!(:user_token) { JsonWebToken.encode(user_id: user.id) }
  let!(:headers) { {'Authentication': user_token} }

  before(:each) do
    @user = create(:user, email: 'bios111@gmail.com', password: '12345678',
      password_confirmation: '12345678')
    login_user#(route: api_v1_authenticate_path)
  end


  describe "index and show" do
    it "get index" do
      #binding.pry
      get api_v1_users_path
      expect(response).to have_http_status('200')
      expect(json).not_to be_empty
    end

    it "get show" do
      get api_v1_users_path(@user),params: {user: {email: 'bios111@gmail.com',
          password: '12345678'}}, headers: headers
      expect(response).to have_http_status('200')
      expect(json).not_to be_empty
    end
  end

  describe "#creates users" do

    it "creates users" do
      post api_v1_users_path, params: {user: {email: 'bios111@gmail.com',
          password: '12345678', password_confirmation: '12345678'}}, headers: headers
      user_token = JSON.parse(response.body)['token']
      new_user = User.find_by(email: 'bios111@gmail.com')
      expected = {user: new_user, user_token: user_token}.to_json
      expect(response.body).to eq(expected)
    end

    it "increases count by 1" do
      expect do
        post api_v1_users_path params: {user: {email: 'bios111@gmail.com',
            password: '12345678', password_confirmation: '12345678'}}
      end.to change { User.count }.by(1)
    end

    it "doesn't creates users" do
      post api_v1_users_path params: {user: {email: '', password: '',
          password_confirmation: ''}}
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['error']).to eq("Invalid email or password")
    end

    it "not increases count" do
      expect do
        post api_v1_users_path params: {user: {email: '',
            password: '', password_confirmation: ''}}
      end.to change { User.count }.by(0)
    end
  end
end
