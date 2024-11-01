class Session < ApplicationRecord
    # Relationships
    belongs_to :user
  
    # Validations
    validates :user_id, presence: true
    validates :token, presence: true, uniqueness: true
  
    # Callbacks
    before_validation :generate_session_token, on: :create
  
    private
  
    # Generate a unique token for the session
    def generate_session_token
      self.token ||= SecureRandom.hex(20)  # Generates a random 40-character token
    end
  end
  