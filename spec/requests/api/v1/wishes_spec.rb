# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'Wishes API', type: :request do
  path '/api/user_wishes/{user_id}' do
    get 'Get user wishes' do
      tags 'Wishes'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, description: 'User ID'
      parameter name: :o, in: :query, type: :string, required: false, description: 'Order'

      response '200', 'Success' do
        schema type: :array, items: { type: :object }
        run_test!
      end
    end
  end

  path '/api/realised_user_wishes/{user_id}' do
    get 'Get realised user wishes' do
      tags 'Wishes'
      produces 'application/json'
      parameter name: :user_id, in: :path, type: :string, description: 'User ID'
      parameter name: :o, in: :query, type: :string, required: false, description: 'Order'

      response '200', 'Success' do
        schema type: :array, items: { type: :object }
        run_test!
      end
    end
  end

  path '/api/wishes' do
    get 'List current user wishes' do
      tags 'Wishes'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Success' do
        schema type: :array, items: { type: :object }
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

    post 'Create a wish' do
      tags 'Wishes'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :wish, in: :body, schema: {
        type: :object,
        properties: {
          wish: {
            type: :object,
            properties: {
              body: { type: :string, description: 'Text description' },
              url: { type: :string, description: 'URL' }
            }
          }
        }
      }

      response '200', 'Success' do
        schema type: :object
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

  path '/api/wishes/{id}' do
    parameter name: :id, in: :path, type: :integer, description: 'Wish ID'

    get 'Get a wish' do
      tags 'Wishes'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Success' do
        schema type: :object
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

    put 'Update a wish' do
      tags 'Wishes'
      consumes 'application/json'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :wish, in: :body, schema: {
        type: :object,
        properties: {
          wish: {
            type: :object,
            properties: {
              body: { type: :string, description: 'Text description' },
              url: { type: :string, description: 'URL' }
            }
          }
        }
      }

      response '200', 'Success' do
        schema type: :object
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end

    delete 'Delete a wish' do
      tags 'Wishes'
      produces 'application/json'
      security [bearer_auth: []]

      response '200', 'Success' do
        schema type: :object
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

  path '/api/wishes/{id}/realise' do
    put 'Mark wish as realised' do
      tags 'Wishes'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer, description: 'Wish ID'

      response '200', 'Success' do
        schema type: :object
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

  path '/api/wishes/{id}/book' do
    put 'Book a wish' do
      tags 'Wishes'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer, description: 'Wish ID'

      response '200', 'Success' do
        schema type: :object
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end

  path '/api/wishes/{id}/unbook' do
    put 'Unbook a wish' do
      tags 'Wishes'
      produces 'application/json'
      security [bearer_auth: []]
      parameter name: :id, in: :path, type: :integer, description: 'Wish ID'

      response '200', 'Success' do
        schema type: :object
        run_test!
      end

      response '401', 'Unauthorized' do
        run_test!
      end
    end
  end
end
