# frozen_string_literal: true

class V1::MeasurementsController < ActionController::Base # rubocop:disable Style/ClassAndModuleChildren
  def create
    render nothing: true, status: 202
  end
end
