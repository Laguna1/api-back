require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'Validations' do
    let(:activity) { create :activity}

    it 'it has a valid factory' do
      track = build :track, activity: activity
      expect(track).to be_valid
    end

    it 'it has a valid name' do
      track = build :track, activity: activity, name: ''
      expect(track).not_to be_valid
      expect(track.errors[:name]).to include("can't be blank")
    end

    it 'it has a valid distance' do
      track = build :track, activity: activity, distance: nil
      expect(track).not_to be_valid
      expect(track.errors[:distance]).to include("can't be blank")
    end

    it 'it has a valid duration' do
      track = build :track, activity: activity, duration: nil
      expect(track).not_to be_valid
      expect(track.errors[:duration]).to include("can't be blank")
    end

    it 'it has a valid repeat' do
      track = build :track, activity: activity, repeat: nil
      expect(track).not_to be_valid
      expect(track.errors[:repeat]).to include("can't be blank")
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:distance) }
    it { should validate_presence_of(:repeat) }
end
end
