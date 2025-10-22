require 'rails_helper'

RSpec.describe ComplexityCalculatorService do
  include Dry::Monads[:result]

  describe '#call' do
    context 'when definition is Success' do
      it 'calculates complexity and returns rounded float' do
        definition = [
          {
            "word" => "test",
            "meanings" => [
              {
                "partOfSpeech" => "verb",
                "definitions" => [{ "definition" => "d1" }, { "definition" => "d2" }],
                "antonyms" => ["a1"],
                "synonyms" => ["s1", "s2"]
              },
              {
                "partOfSpeech" => "noun",
                "definitions" => [{ "definition" => "n1" }],
                "antonyms" => [],
                "synonyms" => []
              },
              {
                "partOfSpeech" => "adjective",
                "definitions" => [{ "definition" => "adj1" }],
                "antonyms" => [],
                "synonyms" => ["s3"]
              }
            ]
          }
        ]

        definition = Success(definition)
        result = described_class.new(definition).call

        expect(result).to eq(1.33)
      end
    end

    context 'when definition is Failure' do
      it 'returns error message from failure payload' do
        failure_payload = { "message" => "Not found" }
        definition = Failure(failure_payload)

        result = described_class.new(definition).call

        expect(result).to eq("Not found")
      end
    end
  end
end