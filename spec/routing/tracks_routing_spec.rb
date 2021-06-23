require 'rails_helper'

RSpec.describe TracksController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/activs/1/tracks').to route_to('tracks#index', activ_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/activs/1/tracks/1').to route_to('tracks#show', activ_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/activs/1/tracks').to route_to('tracks#create', activ_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/activs/1/tracks/1').to route_to('tracks#update', activ_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/activs/1/tracks/1').to route_to('tracks#update', activ_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/activs/1/tracks/1').to route_to('tracks#destroy', activ_id: '1', id: '1')
    end
  end
end
