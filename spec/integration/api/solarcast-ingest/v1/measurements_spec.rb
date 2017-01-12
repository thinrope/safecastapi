# frozen_string_literal: true

feature '/v1/measurements API endpoint', type: :request do
  let(:user) { Fabricate(:user) }

  before do
    post '/v1/measurements', {
      api_key: user.authentication_token,
      air_import: { source: fixture_file_upload('solarcast-1553490618.txt') }
    }, 'HTTP_ACCEPT' => Mime::JSON.to_s
  end

  it { expect(response.status).to eq(202) } # Accepted
end
