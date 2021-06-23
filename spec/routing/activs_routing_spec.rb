require 'rails_helper'

RSpec.describe ActivsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/activs').to route_to('activs#index')
    end

    it 'routes to #show' do
      expect(get: '/activs/1').to route_to('activs#show', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/activs').to route_to('activs#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/activs/1').to route_to('activs#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/activs/1').to route_to('activs#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/activs/1').to route_to('activs#destroy', id: '1')
    end
  end
end
