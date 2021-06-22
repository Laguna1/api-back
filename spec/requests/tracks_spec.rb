require 'rails_helper'

RSpec.describe '/tracks', type: :request do
  let(:activity) { create :activity }
  let(:activity_id) {activity.id}
  let!(:tracks) { create_list(:track, 10, activity_id: activity.id) }
  let(:id) { tracks.first.id }

  let(:valid_attributes) do
    {
      data: {
        attributes: {
          name: 'Jogging',
          distance: 3000,
          duration: 15,
          repeat: 1,
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
          repeat: 1
        }
      }
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :track, activity: activity
      get "/activities/#{activity.id}/tracks/", as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      create :track, activity: activity
      get "/activities/#{activity.id}/tracks/#{track.id}", as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Track' do
        expect do
          post "/activities/#{activity.id}/tracks",
               params: valid_attributes, as: :json
        end.to change(Track, :count).by(1)
      end

      it 'renders a JSON response with the new track' do
        post "/activities/#{activity.id}/tracks",
             params: valid_attributes, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Track' do
        expect do
          post "/activities/#{activity.id}/tracks",
               params: invalid_attributes, as: :json
        end.to change(Track, :count).by(0)
      end

      it 'renders a JSON response with errors for the new tracking' do
        post "/activities/#{activity.id}/tracks",
             params: invalid_attributes, as: :json
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
              repeat: 7
            }
          }
        }
      end

      it 'updates the requested Track' do
        create :track, activity: activity
        patch "/activities/#{activity.id}/tracks/#{track.id}",
              params: new_attributes, as: :json
        track.reload
        expect(track.name).to eq('New complex')
      end

      it 'renders a JSON response with the track' do
        create :track, activity: activity
        patch "/activities/#{activity.id}/tracks/#{track.id}",
              params: new_attributes, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the track' do
        create :track, activity: activity
        patch "/activities/#{activity.id}/tracks/#{track.id}",
              params: invalid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested track' do
      create :track, activity: activity
      expect do
        delete "/activities/#{activity.id}/tracks/#{track.id}", as: :json
      end.to change(Track, :count).by(-1)
    end
  end
end
