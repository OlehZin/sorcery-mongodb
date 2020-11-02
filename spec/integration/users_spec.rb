require 'swagger_helper'

describe 'Users API' do

  path '/api/v1/users' do
    get 'Index' do
      tags :Users
      produces 'application/json'
      parameter name: 'Authentication', in: :header, type: :string

      response(200, description: 'Return all the available users') do
        schema type: :array,
          items: {
          type: :object,
          properties: {
          id: { type: :string },
          email: { type: :string }
        }}
      let!(:user) { create(:user) }
      let!(:user_token) { JsonWebToken.encode(user_id: user.id) }
      let!(:headers) { {'Authentication': user_token} }
      let(:Authentication) { headers }
      run_test!
      end

      response(401, description: 'Error: Unauthorized') do
        schema type: :object,
        properties: {
          errors: {
            type: :array,
            items: {
              properties: {
                code: { type: :integer, example: 401 },
                message: { type: :string, example: "Not Authorized" },
              }
            },
          },
        }
      let(:Authentication) { '' }
        run_test!
      end
    end
  end

  path '/api/v1/users/{id}' do
  get 'Show' do
    tags :Users
    produces 'application/json'
    parameter name: 'Authentication', in: :header, type: :string
    parameter name: :id, in: :path, type: :string
      response(200, description: 'Return the selected user') do
        schema type: :object,
        properties: {
          id: { type: :string },
          email: { type: :string }
        },
        required: [ 'id', 'email']
      let(:id) { User.create(email: 'bios111@gmail.com', password: '12345678').id }
      let!(:user_token) { JsonWebToken.encode(user_id: user.id) }
      let!(:headers) { {'Authentication': user_token} }
      let(:Authentication) { headers }
      run_test!
      end

      response(404, description: 'user not found') do
        schema type: :object,
        properties: {
          error: {type: :string, example: "Page not found"}
        }
      let(:id) { 'invalid' }
        run_test!
      end

      response(401, description: 'Error: Unauthorized') do
        schema type: :object,
        properties: {
          errors: {
            type: :array,
            items: {
              properties: {
                code: { type: :integer, example: 401 },
                message: { type: :string, example: "Not Authorized" },
              }
            },
          },
        }
      let(:Authentication) { '' }
        run_test!
      end
    end
  end

  path '/api/v1/users' do
    post 'Create' do
      tags :Users
      consumes 'application/json'
      parameter name: 'Authentication', in: :header, type: :string
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
        let!(:user) { create(:user) }
        let!(:user_token) { JsonWebToken.encode(user_id: user.id) }
        let!(:headers) { {'Authentication': user_token} }
        let(:Authentication) { headers }
        run_test!
      end

      response(422, description: 'invalid request') do
        produces 'application/json'
        schema type: :object,
          properties: {
            error: { type: :string, example: "Invalid email or password"},
          },
          required: ['error']
      let(:user) { { email: 'string', password: 'string' } }
        run_test!
      end

      response(401, description: 'Error: Unauthorized') do
        schema type: :object,
        properties: {
          errors: {
            type: :array,
            items: {
              properties: {
                code: { type: :integer, example: 401 },
                message: { type: :string, example: "Not Authorized" },
              }
            },
          },
        }
      let(:Authentication) { '' }
        run_test!
      end
    end
  end
end
