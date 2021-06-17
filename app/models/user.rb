class User < ApplicationRecord
  has_many :activities, dependent: :destroy
  has_many :trackings, through: :activities
  has_one :access_token, dependent: :destroy

  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, presence: true, length: { minimum: 6 }

  def password
    @password ||= Password.new(encrypted_password) if encrypted_password.present?
  end

  def password=(new_password)
    if new_password.blank?
      @password = new_password
    else
      @password = Password.create(new_password)
      self.encrypted_password = @password
    end
  end
end
