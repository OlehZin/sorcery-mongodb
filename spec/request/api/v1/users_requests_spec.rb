require 'rails_helper'
RSpec.describe Api::V1::UsersController, type: :request do
  let!(:user) { create(:user) }
  let!(:user_token) { JsonWebToken.encode(user_id: user.id) }
  let!(:headers) { {'Authentication': user_token} }

  describe "index and show" do
    it "get index" do
      get api_v1_users_path, headers: headers
      expect(response).to have_http_status('200')
      expect(json).not_to be_empty
    end

    it "get show" do
      get api_v1_user_path(user), headers: headers
      expect(response).to have_http_status('200')
      expect(json).not_to be_empty
    end
  end

  describe "#creates users" do
    it "creates users" do
      init_count = User.count
      post api_v1_users_path, params: {user: {email: 'bios111@gmail.com',
          password: '12345678', password_confirmation: '12345678'}},
          headers: headers
      new_user = User.find_by(email: 'bios111@gmail.com')
      expected = {user: new_user}.to_json
      expect(User.count).to eq(init_count+1)
      expect(response.body).to eq(expected)
    end

    # TODO merge two tests
    it "doesn't creates users" do
      post api_v1_users_path params: {user: {email: '', password: '',
          password_confirmation: ''}}
      expected = {errors: [{ code: 401, message: 'Not Authorized' }]}.to_json
      expect(response.body).to eq(expected)
    end

    it "not increases count" do
      expect do
        post api_v1_users_path params: {user: {email: '',
            password: '', password_confirmation: ''}}
      end.to change { User.count }.by(0)
    end
  end
end
