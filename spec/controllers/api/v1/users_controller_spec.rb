require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:user) { create(:user) }
  before { sign_in_as(user) }

  describe 'GET #me' do
    let!(:story) { create(:story, user: user) }

    it 'returns a success response' do
      get :me
      expect(response).to be_successful
      expect(response_json).to eq user.as_json(only: [:id, :nickname, :email])
    end
  end

  describe 'GET #profile' do
    let!(:story) { create(:story, user: user) }

    it 'returns a users id, nickname, and story/arc submissions' do
      stories = user.stories.all
      arcs = user.arcs.all
      anticipated_response = { user: user, stories: stories, arcs: arcs }
      get :profile, params: { id: user.id }
      expect(response).to be_successful
      expect(response_json.to_json).to eq anticipated_response.to_json
    end

  end

end


