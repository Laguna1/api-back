require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'Validations' do
    let(:user) { create :user }

    it 'has a valid factory' do
      activity = build :activity, user: user
      expect(activity).to be_valid
      activity.save!
      another_activity = build :activity, user: user
      expect(another_activity).to be_valid
    end
    
    it { should validate_presence_of(:item) }
  end
  
  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
