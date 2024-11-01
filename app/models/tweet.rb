class Tweet < ApplicationRecord
    # Relationships
    belongs_to :user
  
    # Validations
    validates :user_id, presence: true
    validates :message, presence: true, length: { maximum: 140 }
  end
  