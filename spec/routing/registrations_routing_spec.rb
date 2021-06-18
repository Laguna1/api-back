require 'rails_helper'

describe 'RegistrationsController', type: :routing do
  describe 'routing' do
    it 'routes to registrations#create' do
      expect(post('/sign_up')).to route_to('registrations#create')
    end
  end
end
