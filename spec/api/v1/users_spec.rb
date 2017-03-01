require 'rails_helper'

describe 'User API' do
  describe 'GET /' do
    let!(:users) { create_list(:user, 10) }
    let(:first_five_users) { User.ordered.first(5) }
    let(:last_five_users) { User.ordered.last(5) }

    it 'redirects to root if format != json' do
      get '/api/v1/users', format: :html

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to '/'
    end

    it 'returns first 5 users by default' do
      get '/api/v1/users', format: :json

      expect(response).to have_http_status(:success)
      expect(response.body).to have_json_size(5)
      expect(response.body).to be_json_eql(first_five_users.to_json)
    end

    it 'returns the next 5 users if page param is set' do
      get '/api/v1/users?page=2', format: :json

      expect(response).to have_http_status(:success)
      expect(response.body).to have_json_size(5)
      expect(response.body).to be_json_eql(last_five_users.to_json)
    end

    it 'contains all necessary data' do
      get '/api/v1/users', format: :json

      expect(response).to have_http_status(:success)

      %i(id first_name last_name email user_name).each do |attribute|
        user = first_five_users.first
        expect(response.body).to be_json_eql(user.send(attribute).to_json).at_path("0/#{attribute}")
      end
    end
  end
end
