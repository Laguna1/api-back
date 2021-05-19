require 'rails_helper'

RSpec.describe 'Activities', type: :request do
  let!(:user) { create(:user) }
  let!(:activities) { create_list(:activity, 10, user_id: user.id) }
  let(:user_id) { user.id }
  let(:id) { activities.first.id }

  describe 'GET users/:user_id/activities' do
    before { get "/users/#{user_id}/activities" }

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

  describe 'GET /users/:user_id/activities/:id' do
    before { get "/users/#{user_id}/activities/#{id}" }

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

  describe 'POST post "/users/:user_id/activities' do
    let(:valid_attributes) do
      { activity: { name: 'Swimming', place: 'Aquarena-Pool', intensity: 'middle', user_id: user_id } }
    end

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/activities", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(200)
      end

      context 'when an invalid request' do
        before { post "/users/#{user_id}/activities", params: { activity: { name: '' } } }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a failure message' do
          expect(response.body).not_to match(/Unable to create Activity/)
        end
      end
    end
  end

  describe 'PUT /users/:user_id/activities/:id' do
    let(:valid_attributes) { { activity: { name: 'MyActivity' } } }

    before { put "/users/#{user_id}/activities/#{id}", params: valid_attributes }

    context 'when Activities exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates the Activity' do
        updated_activity = Activity.find(id)
        expect(updated_activity.name).to match(/MyActivity/)
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

  describe 'DELETE /users/:user_id/activities/:id' do
    before { delete "/users/#{user_id}/activities/#{id}" }
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
