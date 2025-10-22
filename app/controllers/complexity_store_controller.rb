class ComplexityController < ApplicationController
  def create 
    words = params[:words]

    complexity_result = ComplexityResult.create(job_id: SecureRandom.uuid)

    ComputeComplexityJob.perform_later(words, complexity_result.id)
    
    render json: { job_id: complexity_result.job_id }, status: :ok
  end
end