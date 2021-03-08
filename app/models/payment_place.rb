class PaymentPlace
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :block, :building, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "はハイフンを含む半角数字7桁で入力してください" }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "は全角で記入してください" }
    validates :block, format: { with: /\A[ぁ-んァ-ン一-龥々0-9-ー]/, message: "は全角日本語および半角数字で記入してください" }
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "は半角数字10〜11桁（ハイフンなし）で記入してください" }
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }

  def save
    payment = Payment.create(item_id: item_id, user_id: user_id)
    Place.create(post_code: post_code, prefecture_id: prefecture_id, city: city, block: block,
                 building: building, phone_number: phone_number, payment_id: payment.id)
  end
end