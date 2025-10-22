class DictionaryClient
  include Dry::Monads[:result]

  def initialize
    @connection = connection
  end

  def fetch_definition(word)
    request = @connection.get("/api/v2/entries/en/#{word}")

    Success(request)
  rescue Faraday::Error => e
    Rails.logger.info("DictionaryClient Error: { code: #{e.response[:status]}, body: #{e.response[:body]}}")

    Failure(e) 
  end   

  private

  def connection
    Faraday.new(url: ENV.fetch('DICTIONARY_API_HOST')) do |faraday|
      faraday.response :raise_error
    end
  end
end