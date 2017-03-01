require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  it { should route(:get, 'users').to(controller: 'users', action: 'index') }
  it { should route(:get, 'users/1').to(controller: 'users', action: 'show', id: 1) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:user) { FactoryGirl.create(:user) }

    it 'returns http success' do
      get :show, id: user.id
      expect(response).to have_http_status(:success)
    end
  end
end
