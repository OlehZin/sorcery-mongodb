require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do
    get 'Index' do
      tags :Users
      produces 'application/json'
      security [ basic_auth: [] ]
      response(200, description: 'Return all the available users') do
        schema type: :array,
          items: {
          type: :object,
          properties: {
          id: { type: :string },
          email: { type: :string }
        }}
      let!(:user) { create(:user) }
      #let!(:user_token) { JsonWebToken.encode(user_id: user.id) }
      #let!(:Authentication) { "Basic #{::Base64.strict_encode64(user_id: user.id)}" }
        run_test! do |repsonse|
          body = JSON.parse(response.body)
          puts body
        end
      end

      # response(401, description: 'Not Authorized') do
      #   let!(:Authentication) { 'application/foo' }
      #   run_test!
      # end
    end
  end

  path '/api/v1/users/{id}' do
  get 'Show' do
    tags :Users
    produces 'application/json'
    parameter name: :id, in: :path, type: :string
      response(200, description: 'Return the selected user') do
        schema type: :object,
        properties: {
          id: { type: :string },
          email: { type: :string }
        },
        required: [ 'id', 'email']
      let(:id) { User.create(email: 'bios111@gmail.com', password: '12345678').id }
        run_test!
      end

      response(404, description: 'user not found') do
        let(:id) { 'invalid' }
        run_test!
      end

      # response(401, description: 'Not Authorized') do
      #   let!(:Authentication) { 'application/foo' }
      #   run_test!
      # end
    end
  end

  path '/api/v1/users' do
    post 'Create' do
      tags :Users
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'email', 'password' ]
      }

      response(201, description: 'user created') do
        produces 'application/json'
        schema type: :object,
          properties: {
            id: { type: :string },
            email: { type: :string },
          }
        let(:user) { { email: 'bios111@gmail.com', password: '12345678'} }
        run_test!
      end

      response(422, description: 'invalid request') do
        produces 'application/json'
        schema type: :object,
          properties: {
            id: { type: :string },
            email: { type: :string },
          }
        let(:user) { { email: 'bios111@gmail.com' } }
        run_test!
      end

      # response(401, description: 'Not Authorized') do
      #   let!(:Authentication) { 'application/foo' }
      #   run_test!
      # end
    end
  end
end
