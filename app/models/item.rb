class Item < ApplicationRecord
  validates :title, :description, :category_id, :condition_id, :postage_id, :prefecture_id, :shipment_day_id, :price, presence: true
  validates :category_id, :condition_id, :postage_id, :prefecture_id, :shipment_day_id, numericality: { other_than: 1 }

  PRICE_REGEX = /\A(?=.*?[\d])[300-9999999]+\z/.freeze
  validates_format_of :price, with: PRICE_REGEX, message: 'は半角数字を使用し、300から9,999,999の間で入力してください'

  belongs_to :user
  has_one :payment
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :postage, :prefecture, :shipment_day
 
end
