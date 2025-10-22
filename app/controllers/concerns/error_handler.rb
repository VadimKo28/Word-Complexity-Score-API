module ErrorHandler
  extend ActiveSupport::Concern
  
   included do
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActionController::ParameterMissing, with: :render_bad_request
  end

  private

  def render_not_found(exception)
    Rails.logger.info("[NotFound] #{exception.class}: #{exception.message}")
    render json: { error: "Not Found" }, status: :not_found
  end

  def render_bad_request(exception)
    Rails.logger.info("[BadRequest] #{exception.class}: #{exception.message}")
    render json: { error: "BadRequest" }, status: :bad_request
  end
end