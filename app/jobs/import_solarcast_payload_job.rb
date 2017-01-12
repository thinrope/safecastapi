class ImportSolarcastPayloadJob
  attr_reader :solarcast_payload_id

  def initialize(solarcast_payload_id)
    @solarcast_payload_id = solarcast_payload_id
  end

  def perform
    raise "Cannot find SolarcastPayload with id = #{solarcast_payload_id}" unless payload
    each_payload do |parsed, json|
      device = Device.find(parsed['device_id'])
      device.measurements.create!(measurement_attributes(parsed, json))
    end
  end

  private

  def each_payload
    StringIO.new(payload).each_line.lazy
      .map(&:chomp)
      .select(&:present?)
      .each do |json|
        yield(JSON.parse(json), json)
      end
  end

  def measurement_attributes(hsh, json)
    {
      captured_at: Time.parse(hsh['captured_at']),
      location: format('POINT(%s %s)', hsh['longitude'], hsh['latitude']),
      value: 0.0,
      unit: 'N/A',
      md5sum: Digest::MD5.hexdigest(json)
    }
  end

  def payload
    solarcast_payload.try!(:payload)
  end

  def solarcast_payload
    @solarcast_payload ||= begin
                   SolarcastPayload.find(solarcast_payload_id)
                 rescue ActiveRecord::RecordNotFound => _e
                   nil
                 end
  end
end
