require 'rails_helper'

RSpec.describe "Home", type: :request do
  describe "Home" do
    it "get home page" do
    get root_path
    expect(response).to be_successful
    end
  end
end
