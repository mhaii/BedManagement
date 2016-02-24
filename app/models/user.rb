class User < ActiveRecord::Base
  enum role: [:cashier, :nurseAssistance, :nurse, :admission, :administrator]
  validates :username, presence: true, length: { maximum: 20 }
  validate :password_input


  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end


  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  private
    def password_input
      if !password_digest.blank?
        errors[:base] << 'Invalid password digest' unless BCrypt::Password.valid_hash? password_digest
      elsif !password.blank?
        errors[:base] << 'Invalid password length' unless password.length < 6
      else
        errors[:base] << 'Either password phrase or digest is required'
      end
    end
end
