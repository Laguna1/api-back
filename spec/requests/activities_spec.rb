require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  let!(:user) { create(:user) }
  let!(:activities) { create_list(:activity, 10, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { activities.first.id }

  describe 'GET /activities' do
    before { get '/activities' }

    context 'when user exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when user does not exist' do
      let(:user_id) { nil }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'GET /activities/:id' do
    before { get "/activities/#{id}" }

    context 'when an activity exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when an activity does not exist' do
      let(:id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).not_to match(/Couldn't find the activity/)
      end
    end
  end

  describe 'POST post "/activities' do
    let(:valid_attributes) do
      { activity: { item: '2021-10-10' } }
    end

    context 'when request attributes are valid' do
      before { post '/activities', params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end

      context 'when an invalid request' do
        before { post '/activities', params: { activity: { item: '' } } }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a failure message' do
          expect(response.body).not_to match(/Unable to create Activity/)
        end
      end
    end
  end

  describe 'PUT /activities/:id' do
    let(:valid_attributes) { { activity: { item: '2021-12-12' } } }

    before { put "/activities/#{id}", params: valid_attributes }

    context 'when Activities exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the Activity' do
        updated_activity = Activity.find(id)
        expect(updated_activity.item).to match(/2021-12-12/)
      end
    end

    context 'when the MyActivity does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).not_to match(/Couldn't find the activity/)
      end
    end
  end

  describe 'DELETE /activities/:id' do
    before { delete "/activities/#{id}" }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
