require 'rails_helper'

RSpec.describe 'Activs', type: :request do
  let(:user) { create :user }

  let(:valid_attributes) { { item: '20210623' } }

  let(:invalid_attributes) { { item: '' } }

  let(:valid_headers) do
    {
      Authorization: "Bearer #{user.create_access_token.token}"
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create :activ, user: user
      get activs_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      activ = create :activ, user: user
      get activ_url(activ), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Activ' do
        expect do
          post activs_url,
               params: { data: {
                 attributes: valid_attributes
               } }, headers: valid_headers, as: :json
        end.to change(Activ, :count).by(1)
      end

      it 'renders a JSON response with the new activ' do
        post activs_url,
             params: { data: {
               attributes: valid_attributes
             } }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new activ' do
        expect do
          post activs_url,
               params: { data: { attributes: invalid_attributes } },
               headers: valid_headers, as: :json
        end.to change(Activ, :count).by(0)
      end

      it 'renders a JSON response with errors for the new activ' do
        post activs_url,
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
          item: '20211010'
        }
      end

      it 'updates the requested activ' do
        activ = create :activ, user: user
        expect do
          patch activ_url(activ),
                params: { data: { attributes: new_attributes } },
                headers: valid_headers, as: :json
          activ.reload
        end.to change(Activ, :count).by(0)
      end

      it 'renders a JSON response with the activity' do
        activ = create :activ, user: user
        patch activ_url(activ),
              params: { data: { attributes: new_attributes } },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the activ' do
        activ = create :activ, user: user
        patch activ_url(activ),
              params: { data: { attributes: invalid_attributes } },
              headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
