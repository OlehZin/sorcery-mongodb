require 'swagger_helper'

describe 'Sessions API' do
  path '/api/v1/authenticate' do
    post 'Authenticate' do
      tags :Sessions
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: [ 'email', 'password' ]
      }}}

      response(201, description: 'user logged') do
        produces 'application/json'
        schema type: :object,
          properties: {
            id: { type: :string },
            email: { type: :string },
          },
        required: [ 'email', 'password' ]
        let!(:user) { {user: {email: 'bios111@gmail.com', password: '12345678'}} }
        run_test!
      end

      response(401, description: 'authentication failed') do
        produces 'application/json'
        schema type: :object,
          properties: {
            error: { type: :string, example: "Invalid email or password"},
          },
        required: ['error']
        let!(:user) { {user: {email: '', password: ''}} }
        run_test!
      end
    end
  end
end
