RSpec.describe ImportSolarcastPayloadJob, type: :job do
  let(:user) { Fabricate(:user) }
  let(:device_id) { 1_553_490_618 }
  let!(:device) { Device.create!(id: device_id, manufacturer: 'Safecast', model: 'Solarcast', sensor: 'LND-7317') }

  describe '#perform' do
    before do
      payload = user.solarcast_payloads.create!(payload: Rails.root.join("spec/fixtures/solarcast-#{device_id}.txt").read)
      job = described_class.new(payload.id)
      job.perform
    end

    it 'should import measurements' do
      expect(user.reload.measurements).to be_exist
    end
  end
end
