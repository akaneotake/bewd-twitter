class Session < ApplicationRecord
    # Relationships
    belongs_to :user
  
    # Validations
    validates :user_id, presence: true
    validates :token, presence: true, uniqueness: true
  
    before_validation :generate_session_token

    def generate_session_token
      self.token ||= SecureRandom.hex(16)  # Generates a 32-character hexadecimal string
    end
    
  end
  