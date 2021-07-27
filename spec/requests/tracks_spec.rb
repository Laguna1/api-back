require 'rails_helper'

RSpec.describe 'Tracks', type: :request do
  let(:user) { create :user }
  let(:activ) { create :activ, user: user }

  let(:valid_attributes) do
    {
      data: {
        attributes: {
          name: 'Jogging',
          distance: 3000,
          duration: 15,
          repeat: 1
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

  let(:valid_headers) do
    {
      Authorization: "Bearer #{user.create_access_token.token}"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :track, activ: activ
      get "/activs/#{activ.id}/tracks",
          headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      track = create :track, activ: activ
      get "/activs/#{activ.id}/tracks/#{track.id}",
          headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Track' do
        expect do
          post "/activs/#{activ.id}/tracks",
               params: valid_attributes,
               headers: valid_headers, as: :json
        end.to change(Track, :count).by(1)
      end

      it 'renders a JSON response with the new track' do
        post "/activs/#{activ.id}/tracks",
             params: valid_attributes,
             headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Track' do
        expect do
          post "/activs/#{activ.id}/tracks",
               params: invalid_attributes,
               headers: valid_headers, as: :json
        end.to change(Track, :count).by(0)
      end

      it 'renders a JSON response with errors for the new track' do
        post "/activs/#{activ.id}/tracks",
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
              repeat: 7
            }
          }
        }
      end

      it 'updates the requested track' do
        track = create :track, activ: activ
        patch "/activs/#{activ.id}/tracks/#{track.id}",
              params: new_attributes,
              headers: valid_headers, as: :json
        track.reload
        expect(track.name).to eq('New complex')
      end

      it 'renders a JSON response with the track' do
        track = create :track, activ: activ
        patch "/activs/#{activ.id}/tracks/#{track.id}",
              params: new_attributes,
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the tracke' do
        track = create :track, activ: activ
        patch "/activs/#{activ.id}/tracks/#{track.id}",
              params: invalid_attributes,
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested track' do
      track = create :track, activ: activ
      expect do
        delete "/activs/#{activ.id}/tracks/#{track.id}",
               headers: valid_headers, as: :json
      end.to change(Track, :count).by(-1)
    end
  end
end
