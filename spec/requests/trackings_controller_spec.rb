require 'rails_helper'

RSpec.describe '/trackings', type: :request do
  let(:user) { create :user }
  let(:activity) { create :activity, user: user }

  let(:valid_attributes) do
    {
      data: {
        attributes: {
          name: 'Jogging',
          distance: 3000,
          duration: 15,
          repeats: 1
        }
      }
    }
  end

  let(:invalid_attributes) do
    {
      data: {
        attributes: {
          name: '',
          distance: 500,
          duration: 15,
          repeats: 1
        }
      }
    }
  end

  let(:valid_headers) do
    {
      Authorization: "Bearer #{user.create_access_token.token}"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :tracking, activity: activity
      get "/activities/#{activity.id}/trackings",
          headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      create :tracking, activity: activity
      get "/activities/#{activity.id}/trackings/#{tracking.id}",
          headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Tracking' do
        expect do
          post "/activities/#{activity.id}/trackings",
               params: valid_attributes,
               headers: valid_headers, as: :json
        end.to change(Tracking, :count).by(1)
      end

      it 'renders a JSON response with the new tracking' do
        post "/activities/#{activity.id}/trackings",
             params: valid_attributes,
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Tracking' do
        expect do
          post "/activities/#{activity.id}/trackings",
               params: invalid_attributes,
               headers: valid_headers, as: :json
        end.to change(Tracking, :count).by(0)
      end

      it 'renders a JSON response with errors for the new tracking' do
        post "/activities/#{activity.id}/trackings",
             params: invalid_attributes,
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          data: {
            attributes: {
              name: 'New complex',
              distance: 500,
              duration: 5,
              repeats: 7
            }
          }
        }
      end

      it 'updates the requested tracking' do
        create :tracking, activity: activity
        patch "/activities/#{activity.id}/trackings/#{tracking.id}",
              params: new_attributes,
              headers: valid_headers, as: :json
        tracking.reload
        expect(tracking.name).to eq('New complex')
      end

      it 'renders a JSON response with the tracking' do
        create :tracking, activity: activity
        patch "/activities/#{activity.id}/trackings/#{tracking.id}",
              params: new_attributes,
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the tracke' do
        create :tracking, activity: activity
        patch "/activities/#{activity.id}/trackings/#{tracking.id}",
              params: invalid_attributes,
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested tracking' do
      create :tracking, activity: activity
      expect do
        delete "/activities/#{activity.id}/trackings/#{tracking.id}",
               headers: valid_headers, as: :json
      end.to change(Tracking, :count).by(-1)
    end
  end
end
