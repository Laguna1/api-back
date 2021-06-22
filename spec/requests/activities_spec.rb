require 'rails_helper'

RSpec.describe '/activities', type: :request do
  let(:valid_attributes) { { item: '20210618' } }

  let(:invalid_attributes) { { item: '' } }
 
  describe 'GET /index' do
    it 'renders a successful response' do
      create :activity
      get activities_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      activity = create :activity
      get activity_url(activity), as: :json
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
               } }, as: :json
        end.to change(Activity, :count).by(1)
      end

      it 'renders a JSON response with the new activity' do
        post activities_url,
             params: { data: {
               attributes: valid_attributes
             } }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new activity' do
        expect do
          post activities_url,
               params: { data: { attributes: invalid_attributes } }, as: :json
        end.to change(Activity, :count).by(0)
      end

      it 'renders a JSON response with errors for the new activity' do
        post activities_url,
             params: { data: { attributes: invalid_attributes } }, as: :json
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
        activity = create :activity
        expect do
          patch activity_url(activity),
                params: { data: { attributes: new_attributes } }, as: :json
          activity.reload
        end.to change(Activity, :count).by(0)
      end

      it 'renders a JSON response with the activity' do
        activity = create :activity
        patch activity_url(activity),
              params: { data: { attributes: new_attributes } }, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the activity' do
        activity = create :activity
        patch activity_url(activity),
              params: { data: { attributes: invalid_attributes } }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested activity' do
      activity = create :activity
      expect do
        delete activity_url(activity), as: :json
      end.to change(Activity, :count).by(-1)
    end
  end
end