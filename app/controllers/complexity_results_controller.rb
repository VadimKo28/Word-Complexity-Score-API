class ComplexityResultsController < ApplicationController
  def create 
    words = words_param

    complexity_result = ComplexityResult.create(job_id: SecureRandom.uuid)

    CalculateComplexityJob.perform_later(words, complexity_result.id)
    
    render json: { job_id: complexity_result.job_id }, status: :ok
  end

  def show
    complexity_result = ComplexityResult.find_by!(job_id: params[:job_id])

    render json: { status: complexity_result.status, result: complexity_result.result }, status: :ok
  end

  private 

  def words_param
    params.require(:words)
  end
end