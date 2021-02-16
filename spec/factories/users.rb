FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name           {'山田'}
    first_name            {'陸太郎'}
    family_name_reading   {'ヤマダ'}
    first_name_reading    {'リクタロウ'}
    birthday              {'1999-09-09'}
  end
end