require 'rails_helper'

RSpec.describe Api::V1::Admin::Users::StoriesController, type: :controller do
  let(:user) { create(:user) }
  let(:manager) { create(:user, role: :manager) }
  let(:admin) { create(:user, role: :admin) }
  let!(:story) { create(:story, user: user) }
  let!(:story2) { create(:story, user: manager) }

  describe 'GET #index' do
    it 'allows admin to receive storiess list' do
      sign_in_as(admin)
      get :index, params: { user_id: admin.id }
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq story.id
    end

    it 'allows manager to receive users list' do
      sign_in_as(manager)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(403)
    end

    it 'does not allow regular user to receive users list' do
      sign_in_as(user)
      get :index, params: { user_id: user.id }
      expect(response).to have_http_status(403)
    end
  end
end