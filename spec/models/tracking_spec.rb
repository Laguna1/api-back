require 'rails_helper'

RSpec.describe Tracking, type: :model do
  describe 'Validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:rate) }
    it { should validate_presence_of(:distance) }
  end

  describe 'Associations' do
    it { should belong_to(:activity) }
  end
end
