class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :plece
end
