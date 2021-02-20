class Item < ApplicationRecord
  validates :title, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shipment_day_id, :price, presence: true

  belongs_to :user
  has_one :payment
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :postage, :prefecture, :shipment_day
end
