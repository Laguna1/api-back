require 'rails_helper'

RSpec.describe '/activities', type: :request do
  let(:user) { create :user }

  let(:valid_attributes) { { item: '20210618' } }

  let(:invalid_attributes) { { item: '' } }

  let(:valid_headers) do
    {
      Authorization: "Bearer #{user.create_access_token.token}"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :activity, user: user
      get activities_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      activity = create :activity, user: user
      get activity_url(activity), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Activity' do
        expect do
          post activities_url,
               params: { data: {
                 attributes: valid_attributes
               } }, headers: valid_headers, as: :json
        end.to change(Activity, :count).by(1)
      end

      it 'renders a JSON response with the new activity' do
        post activities_url,
             params: { data: {
               attributes: valid_attributes
             } }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new activity' do
        expect do
          post activities_url,
               params: { data: { attributes: invalid_attributes } },
               headers: valid_headers, as: :json
        end.to change(Activity, :count).by(0)
      end

      it 'renders a JSON response with errors for the new activity' do
        post activities_url,
             params: { data: { attributes: invalid_attributes } },
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
          day: '20211010'
        }
      end

      it 'updates the requested activity' do
        activity = create :activity, user: user
        expect do
          patch activity_url(activity),
                params: { data: { attributes: new_attributes } },
                headers: valid_headers, as: :json
          activity.reload
        end.to change(Activity, :count).by(0)
      end

      it 'renders a JSON response with the activity' do
        activity = create :activity, user: user
        patch activity_url(activity),
              params: { data: { attributes: new_attributes } },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the activity' do
        activity = create :activity, user: user
        patch activity_url(activity),
              params: { data: { attributes: invalid_attributes } },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested activity' do
      activity = create :activity, user: user
      expect do
        delete activity_url(activity), headers: valid_headers, as: :json
      end.to change(Activity, :count).by(-1)
    end
  end
end
