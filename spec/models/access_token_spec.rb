require 'rails_helper'

RSpec.describe AccessToken, type: :model do
  describe 'New' do
    it 'should have a token present after initialize' do
      expect(AccessToken.new.token).to be_present
    end

    it 'should generate a token for the user' do
      user = create :user
      expect { user.create_access_token }.to change { AccessToken.count }.by(1)
    end
  end
  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
