RSpec.describe ImportSolarcastPayloadJob, type: :job do
  describe '#perform' do
    user = Fabricate(:user)
    device_id = 1_553_490_618
    Device.create!(id: device_id, manufacturer: 'Safecast', model: 'Solarcast', sensor: 'LND-7317')
    payload = user.solarcast_payloads.create!(payload: Rails.root.join("spec/fixtures/solarcast-#{device_id}.txt").read)
    job = described_class.new(payload.id)
    job.perform
  end
end
