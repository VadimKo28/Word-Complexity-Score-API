require 'rails_helper'

RSpec.describe GetDefinitionsService do
  include Dry::Monads[:result]

  describe '#call' do
    let(:client_double) { instance_double('DictionaryClient') }

    before do
        allow(::DictionaryClient).to receive(:new).and_return(client_double)
    end

    context 'when client returns success' do
      let(:response_body) { { "word" => "happy", "meanings" => [] }.to_json }
      let(:faraday_response) { instance_double(Faraday::Response, body: response_body) }
      let(:word) { 'happy' }

      it 'returns Success with parsed JSON' do
        allow(client_double).to receive(:fetch_definition).with(word).and_return(Success(faraday_response))

        result = described_class.call(word)

        expect(result).to be_success
        expect(result.value!).to eq(JSON.parse(response_body))
      end
    end

    context 'when client returns failure' do
      let(:error_body) { { "title" => "No Definitions", "message" => "Not found" }.to_json }
      let(:faraday_error) { double('Faraday::Error', response: { body: error_body }) }

      it 'returns Failure with parsed error body' do
        allow(client_double).to receive(:fetch_definition).with('xxxx').and_return(Dry::Monads::Failure(faraday_error))

        result = described_class.new('xxxx').call

        expect(result).to be_failure
        expect(result.failure).to eq(JSON.parse(error_body))
      end
    end
  end
end
