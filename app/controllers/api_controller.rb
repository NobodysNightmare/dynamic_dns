# frozen_string_literal: true

class ApiController < ActionController::Base
  def render_error(status:, message:)
    render json: { error: message }, status: status
  end
end
