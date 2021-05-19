require 'rails_helper'

RSpec.describe 'Trackings API', type: :request do
  let!(:user) { create(:user) }
  let!(:activity) { create(:activity) }
  let!(:trackings) { create_list(:tracking, 10, activity_id: activity.id) }
  let(:user_id) { user.id }
  let(:activity_id) { activity.id }
  let(:id) { trackings.first.id }

  describe 'GET users/:user_id/activities/:activity_id/trackings' do
    before { get "/users/#{user_id}/activities/#{activity_id}/trackings/#{id}" }

    context 'when this activity has trackings' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when activity does not exist' do
      let(:activity_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).not_to match(/Couldn't find the Activity/)
      end
    end
  end

  describe 'GET /users/:user_id/activities/:activity_id/trackings/:id' do
    before { get "/users/#{user_id}/activities/#{activity_id}/trackings/#{id}" }

    context 'when tracking exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
    context 'when tracking does not exist' do
      let(:id) { 0 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tracking/)
      end
    end
  end

  describe 'POST /users/:user_id/activities/:activity_id/trackings' do
    let(:valid_attributes) do
      { tracking: { date: '2021-05-10', pulse: '75', duration: '30', distance: '1000', calories: '120', rate: 'lorem',
                    activity_id: activity_id } }
    end

    context 'when request attributes are valid' do
      before { post "/users/#{user_id}/activities/#{activity_id}/trackings", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/users/#{user_id}/activities/#{activity_id}/trackings", params: { tracking: { temperature: 38 } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a unable to create activity message' do
        expect(response.body).to match(/Unable to create Date/)
      end
    end
  end

  describe 'PUT /users/:user_id/activities/:activity_id/trackings/:id' do
    let(:valid_attributes) { { tracking: { date: '2021-05-10' } } }

    before { put "/users/#{user_id}/activities/#{activity_id}/trackings/#{id}", params: valid_attributes }

    context 'when tracking exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'updates tracking' do
        updated_tracking = Tracking.find(id)
        expect(updated_tracking.date).to eq('2021-05-10')
      end
    end

    context 'when the tracking does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tracking/)
      end
    end
  end

  describe 'DELETE /users/:user_id/activities/:activity_id/trackings/:id' do
    before { delete "/users/#{user_id}/activities/#{activity_id}/trackings/#{id}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
