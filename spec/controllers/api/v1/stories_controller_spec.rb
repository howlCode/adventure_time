require 'rails_helper'

RSpec.describe Api::V1::StoriesController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_attributes) {
    { title: 'new title', body: 'new body'  }
  }

  let(:invalid_attributes) {
    { title: nil, body: nil }
  }
  
  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:story) { create(:story, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq story.id
    end

  end

  describe 'GET #show' do
    let!(:story) { create(:story, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { id: story.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates a new story' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect {
          post :create, params: { story: valid_attributes }
        }.to change(Story, :count).by(1)
      end

      it 'renders a JSON response with the new story' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { story: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(api_v1_story_path(Story.last))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { story: valid_attributes }
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new story' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { story: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    let!(:story) { create(:story, user: user) }

    context 'with valid params' do
      let(:new_attributes) {
        { title: 'Super secret title' }
      }

      it 'updates the requested story' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: story.id, story: new_attributes }
        story.reload
        expect(story.title).to eq new_attributes[:title]
      end

      it 'renders a JSON response with the story' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: story.to_param, story: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the story' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: story.to_param, story: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:story) { create(:story, user: user) }

    it 'destroys the requested story' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect {
        delete :destroy, params: { id: story.id }
      }.to change(Story, :count).by(-1)
    end
  end
end