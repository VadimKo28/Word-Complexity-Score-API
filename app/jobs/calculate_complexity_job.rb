class CalculateComplexityJob < ApplicationJob
  queue_as :default

  def perform(words, complexity_result_id)
    update_status(complexity_result_id, :completed)
  end

  private 

  def update_status(complexity_result_id, status)
    complexity_result = ComplexityResult.find(complexity_result_id)
    complexity_result.update(status: status, result: { score: rand(1..100) })
  end
end