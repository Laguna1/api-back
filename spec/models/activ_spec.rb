require 'rails_helper'

RSpec.describe Activ, type: :model do
  describe 'Validations' do
    let(:user) { create :user }

    it 'has a valid factory' do
      activ = build :activ, user: user
      expect(activ).to be_valid
      activ.save!
      another_activ = build :activ, user: user
      expect(another_activ).to be_valid
    end

    it 'has a valid item' do
      activ = build :activ, user: user, item: ''
      expect(activ).not_to be_valid
      expect(activ.errors[:item]).to include("can't be blank")
    end

    it { should validate_presence_of(:item) }
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
