class User < ActiveRecord::Base
  validates :session_token, :username, :password_digest, presence: true
  validates :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  attr_reader :password

  has_many :cats,
    foreign_key: :owner_id

  has_many :cat_rental_requests

  has_many :sessions

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil unless user
    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    bcrypt_pass = BCrypt::Password.create(password)
    self.password_digest = bcrypt_pass
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def is_password?(password)
    pass = BCrypt::Password.new(self.password_digest)
    pass.is_password?(password)
  end


end
