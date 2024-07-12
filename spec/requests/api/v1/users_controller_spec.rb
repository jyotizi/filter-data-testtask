# spec/controllers/api/v1/users_controller_spec.rb
require 'rails_helper'


RSpec.describe Api::V1::UsersController, type: :request do
  describe 'GET #index' do
    it 'returns all users' do
      get :index
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      post :create, params: { user: { name: 'Bob', email: 'bob@gmail.com', campaigns_list: [{ campaign_name: 'cam5', campaign_id: 'id5' }] } }
      expect(response).to be_created
    end
  end

  describe 'GET #filter' do
    it 'filters users by campaign names' do
      get :filter, params: { campaign_names: 'cam1,cam2' }
      expect(response).to be_successful
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end
end