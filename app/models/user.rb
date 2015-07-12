class User < ActiveRecord::Base
  validates :email, presence: true, 
    uniqueness: true,
    format: { with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9\.-]+\.[A-Za-z]+\Z/ }
  has_many :todo_lists

  def generate_password_reset_token!
    update_attribute(:password_reset_token, SecureRandom.urlsafe_base64(48))
  end
end
