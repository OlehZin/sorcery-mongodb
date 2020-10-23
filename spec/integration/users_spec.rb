require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do
    get 'Index' do
      tags 'Users'
      produces 'application/json', 'application/xml'
      parameter name: :articles, in: :path, type: :string

      response '200', 'users found' do
        schema type: :object,
          properties: {
            id: { type: :string },
            email: { type: :string },
            password: { type: :string },
          },
          required: [ 'email', 'password']

        let(:user) { create(:user) }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:headers) { {'Authentication': user_token} }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Show' do
      tags 'Users'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        schema type: :object,
        properties: {
          id: { type: :string },
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'id', 'email', 'password']

        let(:id) { User.create(email: 'bios111@gmail.com', password: '12345678').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:headers) { {'Authentication': user_token} }
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    post 'Creates a user' do
      tags 'User'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        },
        required: [ 'email', 'password' ]
      }

      response '201', 'user created' do
        let(:user) { { email: 'bios111@gmail.com', password: '12345678'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'bios111@gmail.com' } }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:headers) { {'Authentication': user_token} }
        run_test!
      end
    end
  end
end
