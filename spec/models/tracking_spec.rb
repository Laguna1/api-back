require 'rails_helper'

RSpec.describe Tracking, type: :model do
  describe 'Validations' do
    let(:user) { create :user }
    let(:activity) { create :activity, user: user }

    it 'has a valid factory' do
      tracking = build :tracking, activity: activity
      expect(tracking).to be_valid
    end

    it 'has an invalid name' do
      tracking = build :track, activity: activity, name: ''
      expect(tracking).not_to be_valid
      expect(tracking.errors[:name]).to include("can't be blank")
    end

    it 'has an invalid distance' do
      tracking = build :tracking, activity: activity, distance: nil
      expect(tracking).not_to be_valid
      expect(tracking.errors[:distance]).to include("can't be blank")
    end

    it 'has an invalid duration' do
      tracking = build :tracking, activity: activity, duration: nil
      expect(tracking).not_to be_valid
      expect(tracking.errors[:duration]).to include("can't be blank")
    end

    it 'has an invalid repeats' do
      tracking = build :tracking, activity: activity, repeats: nil
      expect(tracking).not_to be_valid
      expect(tracking.errors[:repeats]).to include("can't be blank")
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:distance) }
    it { should validate_presence_of(:repeats) }
  end

  describe 'Associations' do
    it { should belong_to(:activity) }
  end
end
