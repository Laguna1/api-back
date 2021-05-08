require 'rails_helper'

RSpec.describe Activity, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:place) }
  end
  describe 'Associations' do
    it { should belong_to(:user) }
  end
end
