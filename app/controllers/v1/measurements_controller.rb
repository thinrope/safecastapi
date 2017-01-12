# frozen_string_literal: true

class V1::MeasurementsController < ActionController::Base
  def create
    render nothing: true, status: 202
  end
end
