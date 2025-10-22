class CalculateComplexityJob < ApplicationJob
  queue_as :default

  def perform(words, complexity_result_id)
    definitions = DictionaryClient.new.fetch_definitions(words)

    score = ComplexityCalculator.new.calculate(definitions)

    update_status(complexity_result_id, :completed)
  end

  private 

  def update_status(complexity_result_id, status)
    complexity_result = ComplexityResult.find(complexity_result_id)
    complexity_result.update(status: status)
  end
end