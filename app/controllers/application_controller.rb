class ApplicationController < ActionController::API
  before_action :auth_user
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  protected

  def auth_user
    unless @user = User.find_by(auth_token: request.headers['AuthToken'])
      head :unauthorized
    end
  end

  private

  def render_not_found_response(exception)
    render json: { error: exception.message }, status: :not_found
  end
end