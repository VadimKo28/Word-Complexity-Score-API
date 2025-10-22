class ComplexityResultsController < ApplicationController
  def create 
    words = words_param

    complexity_result = ComplexityResult.create(job_id: SecureRandom.uuid)

    CalculateComplexityJob.perform(words, complexity_result.id)
    
    render json: { job_id: complexity_result.job_id }, status: :ok
  rescue ActionController::ParameterMissing => e
    render json: { error: e.message }, status: :bad_request
  end

  private 

  def words_param
    words = params.require(:words)
  end
end