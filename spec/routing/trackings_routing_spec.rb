require 'rails_helper'

RSpec.describe TrackingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/activities/1/trackings').to route_to('trackings#index', activity_id: '1')
    end

    it 'routes to #show' do
      expect(get: '/activities/1/trackings/1').to route_to('trackings#show', activity_id: '1', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/activities/1/trackings').to route_to('trackings#create', activity_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: '/activities/1/trackings/1').to route_to('trackings#update', activity_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/activities/1/trackings/1').to route_to('trackings#update', activity_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/activities/1/trackings/1').to route_to('trackings#destroy', activity_id: '1', id: '1')
    end
  end
end
