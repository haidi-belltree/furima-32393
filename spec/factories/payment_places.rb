FactoryBot.define do
  factory :payment_place do
    post_code     { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { '横浜市緑区' }
    block         { '青山1-1-1' }
    building      { '柳ビル103' }
    phone_number  { '01234567890' }
    item_price    { '5000' }
    token         { 'tok__abcdefghijk00000000000000000' }
    association :user
    association :item
  end
end
