require 'rails_helper'

RSpec.describe "Api_sessions", type: :request do
  let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678', password_confirmation: '12345678') }

  it "log_in user" do
    #binding.pry
    post api_v1_sessions_path, params: {user: {email: 'bios111@gmail.com', password: '12345678'}}
    token = JSON.parse(response.body)['token']
    expected = {user: user, token: token}.to_json
    expect(response.body).to eq(expected)
  end
  #
  #  it "invalid log_in" do
  #    post api_v1_login params: {user: {email: '', password: ''}}
  #    parsed_response = JSON.parse(response.body)
  #    expect(parsed_response['error']).to eq("Invalid email or password")
  #  end


end
