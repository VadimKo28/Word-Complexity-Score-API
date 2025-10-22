require 'swagger_helper'

RSpec.describe 'ComplexityResultsController', type: :request do
  include Dry::Monads[:result]

  path '/complexity-score' do
    post 'Create ComplexityResult' do
      tags 'ComplexityResults'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          words: {
            type: :array,
            items: { type: :string }
          }
        },
        required: ['words']
      }

      response '200', 'job created' do
        let(:payload) { { words: ['one', 'two', 'three'] } }

        run_test! do
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body).to include('job_id')
        end
      end
    end 
  end 
  
  path '/complexity-score/{job_id}' do
    parameter name: :job_id, in: :path, type: :string, description: 'Job ID'

    get 'Show ComplexityResult' do
      tags 'ComplexityResults'
      produces 'application/json'

      response '200', 'complexity result found' do
        let(:job_id) { 'job-123' }

        before do
          ComplexityResult.create!(job_id: job_id, status: :completed, result: { "a" => 122 })
        end

        run_test! do
          expect(response).to have_http_status(:ok)
          body = JSON.parse(response.body)
          expect(body['status']).to eq('completed')
          expect(body['result']).to eq({ 'a' => 122 })
        end
      end

      response '404', 'not found' do
        let(:job_id) { 'xxxx' }

        run_test! do
          expect(response).to have_http_status(:not_found)
          body = JSON.parse(response.body)
          expect(body).to include('error')
        end
      end
    end
  end
end