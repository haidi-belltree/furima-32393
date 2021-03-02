class Place < ApplicationRecord
  with_options presence: true do
    validates :post_dode, format: { with: /\A\d{3}[-]\d{4}\z/, message: "はハイフンを含む半角数字7桁で入力してください" }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "は全角で記入してください" }
    validates :block, format: { with: /\A[ぁ-んァ-ン一-龥々a-zA-Z0-9-ー]/, message: "は全角日本語および半角英数で記入してください" }
    validates :phone_number, format: { with: /\A[0-9]{10, 11}\z/, message: "は半角数字（ハイフンなし）で記入してください" }
  end
  validates :prefecture, numericality: { other_than: 0, message: "を選択してください" }
  validates :building, format: { with: /\A[ぁ-んァ-ン一-龥々a-zA-Z0-9-ー]/, message: "は全角日本語および半角英数で記入してください" }

  belongs_to :payment
end
