require 'swagger_helper'

describe 'Articles API' do

  path '/api/v1/articles' do
    get 'Index' do
      tags 'Articles'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'articles found' do
        schema type: :object,
          properties: {
            title: { type: :string },
            body: { type: :string },
            published: {type: :boolean}
          },
          required: [ 'title', 'body', 'published' ]

        let(:article) { create(:article, :published) }
        run_test!
      end

      response '404', 'articles not found' do
        let(:article) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end

  path '/api/v1/articles/{id}' do
    get 'Show' do
      tags 'Articles'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'article found' do
        schema type: :object,
          properties: {
            id: { type: :string },
            title: { type: :string },
            body: { type: :string },
            published: {type: :boolean}
          },
          required: [ 'id', 'title', 'body', 'published' ]

        let(:id) { Article.create(title: 'foo', body: 'bar', published: true).id }
        run_test!
      end

      response '404', 'article not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:'Accept') { 'application/foo' }
        run_test!
      end
    end
  end
end
