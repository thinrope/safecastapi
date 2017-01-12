# frozen_string_literal: true

class V1::MeasurementsController < ApplicationController # rubocop:disable Style/ClassAndModuleChildren
  def create
    solarcast = current_user.solarcast_payloads.create!(payload: payload)
    Delayed::Job.enqueue(ImportSolarcastPayloadJob.new(solarcast.id))

    render nothing: true, status: 202
  rescue => _e
    render json: { message: 'Error' }.to_json, status: 500
  end

  def payload
    p = params[:payload]
    p.respond_to?(:read) ? p.read : p
  end
end
