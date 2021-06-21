require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'Validations' do
    
    it 'has a valid factory' do
      activity = build :activity
      expect(activity).to be_valid
      activity.save!
      another_activity = build :activity
      expect(another_activity).to be_valid
    end

    it 'has a valid item' do
      activity = build :activity, item: ''
      expect(activity).not_to be_valid
      expect(activity.errors[:item]).to include("can't be blank")
    end

    it { should validate_presence_of(:item) }
  end
end
