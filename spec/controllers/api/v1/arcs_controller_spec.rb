require 'rails_helper'

RSpec.describe Api::V1::ArcsController, type: :controller do
  let(:user) { create(:user) }
  let(:story) { create(:story) }

  let(:valid_attributes) {
    { body: 'new body', story_id: story.id }
  }

  let(:invalid_attributes) {
    { body: nil, story_id: nil }
  }

  before do
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload)
    @tokens = session.login
  end

  describe 'GET #index' do
    let!(:arc) { create(:arc, story: story, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :index, params: {story_id: story.id}
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq arc.id
    end

  end

  describe 'GET #show' do
    let!(:arc) { create(:arc, story: story, user: user) }

    it 'returns a success response' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      get :show, params: { story_id: story.id, id: arc.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates a new arc' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        expect {
          post :create, params: { arc: valid_attributes, story_id: story.id }
        }.to change(Arc, :count).by(1)
      end

      it 'renders a JSON response with the new arc' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { arc: valid_attributes, story_id: story.id }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(api_v1_story_arc_path(id: Arc.last.id))
      end

      it 'unauth without CSRF' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        post :create, params: { arc: valid_attributes, story_id: story.id }
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new arc' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        post :create, params: { arc: invalid_attributes, story_id: story.id }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'PUT #update' do
    let!(:arc) { create(:arc, story: story, user: user) }

    context 'with valid params' do
      let(:new_attributes) {
        { body: 'Super secret body' }
      }

      it 'updates the requested arc' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: arc.to_param, story_id: story.id, arc: new_attributes } 
        arc.reload
        expect(arc.body).to eq new_attributes[:body]
      end

      it 'renders a JSON response with the arc' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: arc.to_param, story_id: story.id, arc: valid_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the arc' do
        request.cookies[JWTSessions.access_cookie] = @tokens[:access]
        request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
        put :update, params: { id: arc.to_param, story_id: story.id, arc: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:arc) { create(:arc, story: story, user: user) }

    it 'destroys the requested arc' do
      request.cookies[JWTSessions.access_cookie] = @tokens[:access]
      request.headers[JWTSessions.csrf_header] = @tokens[:csrf]
      expect {
        delete :destroy, params: { id: arc.id, story_id: story.id }
      }.to change(Arc, :count).by(-1)
    end
  end
end