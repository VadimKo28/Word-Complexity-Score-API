class GetDefinitionsService < ApplicationService
  include Dry::Monads[:result]

  def initialize(word)
    @word = word
    @client = ::DictionaryClient.new
  end

  def call
    make_request
  end

  private 

  def make_request
    result = @client.fetch_definition(@word)
    if result.success?
      Success(parse_response(result.value!.body))
    else 
      Failure(parse_response(result.failure.response[:body]))
    end  
  end

  def parse_response(response_body)
    JSON.parse(response_body)
  end
end