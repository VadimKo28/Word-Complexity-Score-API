class CalculateComplexityJob < ApplicationJob
  queue_as :default

  def perform(words, complexity_result_id)
    @data = {}

    get_definitions(words)

    update_result_to_db(complexity_result_id, :completed, @data)
  end

  private 

  def get_definitions(words)
    service_results = words.map do |word|
      result = GetDefinitionsService.call(word)

      prepare_calculated_data(word, result)
    end
  end  

  def update_result_to_db(complexity_result_id, status, data)
    complexity_result = ComplexityResult.find(complexity_result_id)
    complexity_result.update!(status: status, result: data)
  end

  def prepare_calculated_data(word, definition)
    result = ComplexityCalculatorService.call(definition)

    @data[word] = result
  end   
end