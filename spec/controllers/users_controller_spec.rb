require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it { should route(:get, 'users').to(controller: 'users', action: 'index') }
  it { should route(:get, 'users/1').to(controller: 'users', action: 'show', id: 1) }

  describe 'GET #index' do
    let!(:users) { create_list(:user, 10) }
    let(:first_five_users) { users.last(5) }
    let(:last_five_users) { users.first(5) }

    before do
      get :index
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it { should render_template('index') }

    it 'assigns instance variable users' do
      expect(assigns(:users)).to match_array(first_five_users)
    end
  end

  describe 'GET #show' do
    let(:user) { create(:user) }

    before do
      get :show, id: user.id
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it { should render_template('show') }

    it 'assigns instance variable user' do
      expect(assigns(:user)).to eq user
    end
  end
end
