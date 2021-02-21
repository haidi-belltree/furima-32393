class Item < ApplicationRecord
  validates :title, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shipment_day_id, :price, presence: true
  validates :category_id, :condition_id, :postage_id, :prefecture_id, :shipment_day_id, numericality: { other_than: 1 }

  belongs_to :user
  has_one :payment
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipment_day
end
