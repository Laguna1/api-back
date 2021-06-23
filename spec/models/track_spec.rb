require 'rails_helper'

RSpec.describe Track, type: :model do
  describe 'Validations' do
    let(:user) { create :user }
    let(:activ) { create :activ, user: user }

    it 'has a valid factory' do
      track = build :track, activ: activ
      expect(track).to be_valid
    end

    it 'has a valid name' do
      track = build :track, activ: activ, name: ''
      expect(track).not_to be_valid
      expect(track.errors[:name]).to include("can't be blank")
    end

    it 'has a valid distance' do
      track = build :track, activ: activ, distance: nil
      expect(track).not_to be_valid
      expect(track.errors[:distance]).to include("can't be blank")
    end

    it 'has a valid duration' do
      track = build :track, activ: activ, duration: nil
      expect(track).not_to be_valid
      expect(track.errors[:duration]).to include("can't be blank")
    end

    it 'has a valid repeat' do
      tracking = build :track, activ: activ, repeat: nil
      expect(tracking).not_to be_valid
      expect(tracking.errors[:repeat]).to include("can't be blank")
    end

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:duration) }
    it { should validate_presence_of(:distance) }
    it { should validate_presence_of(:repeat) }
  end

  describe 'Associations' do
    it { should belong_to(:activ) }
  end
end
