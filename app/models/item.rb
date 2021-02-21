class Item < ApplicationRecord
  validates :title, :category_id, :condition_id, :postage_id, :prefecture_id, :shipment_day_id, :price, :image, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :category_id, :condition_id, :postage_id, :prefecture_id, :shipment_day_id, numericality: { other_than: 1 }
  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'は半角数字を使用し、300から9,999,999の間で入力してください' }

  belongs_to :user
  has_one :payment
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :postage, :prefecture, :shipment_day
 
end
