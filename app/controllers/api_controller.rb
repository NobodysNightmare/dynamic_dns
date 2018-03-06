# frozen_string_literal: true

class ApiController < ActionController::Base
  class Error404 < StandardError
  end

  rescue_from Error404 do |e|
    render_error(status: 404, message: e.message)
  end

  def render_error(status:, message:)
    render json: { error: message }, status: status
  end
end
