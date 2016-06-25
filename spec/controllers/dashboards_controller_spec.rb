RSpec.describe DashboardsController, type: :controller do
  describe 'GET #show' do
    before do
      3.times { Fabricate(:bgeigie_import) }
      Fabricate(:bgeigie_import, approved: true)
    end

    context 'non-login user' do
      before do
        get :show
      end

      it { expect(response).to render_template('home/show') }
    end

    context 'login user' do
      before do
        sign_in Fabricate(:user)

        get :show
      end

      it { expect(response).to render_template('dashboards/show') }

      subject { assigns(:unapproved_bgeigie_import_count) }

      it { is_expected.to be_nil }
    end

    context 'moderator' do
      before do
        sign_in Fabricate(:admin_user)

        get :show
      end

      it { expect(response).to render_template('dashboards/show') }

      subject { assigns(:unapproved_bgeigie_import_count) }

      it { is_expected.to eq(3) }
    end
  end
end
