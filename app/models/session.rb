class Session < ActiveRecord::Base
  validates :user_id, :session_token, :device_type, :ip_address, presence: true
  belongs_to :user

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end
end
