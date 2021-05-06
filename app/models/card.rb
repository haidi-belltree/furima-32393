class Card < ApplicationRecord
  validates :customer_token, :card_token, presence: true
  belongs_to :user
end
