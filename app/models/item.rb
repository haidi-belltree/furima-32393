class Item < ApplicationRecord
  validates :title, :images, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  with_options presence: true,
               numericality: { other_than: 1,
                               message: 'を選択してください' } do
    validates :category_id
    validates :condition_id
    validates :postage_id
    validates :prefecture_id
    validates :shipment_day_id
  end

  with_options presence: true,
               numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                               message: 'は半角数字を使用し、300から9,999,999の間で入力してください' } do
    validates :price
  end

  belongs_to :user
  has_one :payment
  has_many_attached :images

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :shipment_day
end
