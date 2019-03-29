class BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {
      message: "#{exception.model.split(/(?=[A-Z])/).join(' ')} not found"
    }, status: 404
  end
end
