require 'swagger_helper'

describe 'Articles API' do

  path '/api/v1/articles' do
    get 'Index' do
      tags :Articles
      produces 'application/json'
      parameter name: 'Authentication', in: :header, type: :string

      response(200, description: 'Return all the available articles') do
        schema type: :array,
          items: {
          type: :object,
          properties: {
          id:     { type: :string },
          title:  { type: :string },
          body:   { type: :string }
        }}
        it 'Return 10 articles' do
          body = JSON(response.body)
          expect(body.count).to eq(10)
        end
      let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678',
          password_confirmation: '12345678') }
      let!(:article) { create_list(:article, 10, :published) }
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

  path '/api/v1/articles/{id}' do
    get 'Show' do
      tags :Articles
      produces 'application/json'
      parameter name: 'Authentication', in: :header, type: :string
      parameter name: :id, in: :path, type: :string

      response(200, description: 'article found') do
        schema type: :object,
          properties: {
            id: { type: :string },
            title: { type: :string },
            body: { type: :string },
            published: { type: :boolean }
          },
          required: [ 'id', 'title', 'body', 'published']
        let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678',
            password_confirmation: '12345678') }
        let(:id) { Article.create(title: 'foo', body: 'bar', published: true).id }
        run_test!
      end

      response(404, description: 'article not found') do
        let!(:user) { create(:user, email: 'bios111@gmail.com', password: '12345678',
            password_confirmation: '12345678') }
        let(:id) { Article.create(title: '', body: '', published: true).id }
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
