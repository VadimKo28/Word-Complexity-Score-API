require 'rails_helper'

RSpec.describe DictionaryClient do
  include Dry::Monads[:result]

  let(:client) { described_class.new }
  let(:base_url) { ENV.fetch('DICTIONARY_API_HOST') }
  let(:word) { 'happy'}
  let(:expected_url) { "#{base_url}/api/v2/entries/en/#{word}" }

  describe '#fetch_definition' do
    context 'when request is successfull' do
      let(:response_body) do
        JSON.dump(
          [
            {
              "word": "happy",
              "phonetics": [],
              "meanings": [
                {
                  "partOfSpeech": "adjective",
                  "definitions": [
                    {
                      "definition": "(in combination) Favoring or inclined to use.",
                      "synonyms": [],
                      "antonyms": [],
                      "example": "slaphappy, trigger-happy"
                    },
                    {
                      "definition": "(of people, often followed by \"at\" or \"in\") Dexterous, ready, skilful.",
                      "synonyms": [],
                      "antonyms": []
                    }
                  ],
                  "synonyms": ["cheerful"],
                  "antonyms": ["inappropriate", "inapt", "unfelicitous"]
                }
              ]
            }
          ]
        )
      end

      before do
        stub_request(:get, expected_url).to_return(status: 200, body: response_body)
      end

      it 'client return Success monad with response' do
        result = client.fetch_definition(word)

        expect(result).to be_success
        expect(result.value!.body).to eq(response_body)
        expect(result.value!.status).to eq(200)
      end

      before { client.fetch_definition(word) }

      it 'client makes get request to correct endpoint' do
        expect(WebMock).to have_requested(:get, expected_url)
      end
    end

    context 'when request fails with server error' do
      before do
        stub_request(:get, expected_url).to_return({ status: 500, body: 'Internal Server Error'} )
      end

      it 'client returns Failure' do
        result = client.fetch_definition(word)
  
        expect(result).to be_failure
        expect(result.failure.response[:status]).to eq 500
      end 
    end
  end
end