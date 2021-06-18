require 'rails_helper'

describe AccessTokensController, type: :routing do
  describe 'routing' do
    it 'routes to access_tokens create action' do
      expect(post('/login')).to route_to('access_tokens#create')
    end

    it 'should generate token once' do
      user = create :user
      access_token = user.create_access_token
      expect(access_token.token).to eq(access_token.reload.token)
    end

    it 'routes to access_tokens destroy action' do
      expect(delete('/logout')).to route_to('access_tokens#destroy')
    end
  end
end
