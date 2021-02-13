# テーブル設計

## usersテーブル

| Column              | Type    | Options                       |
| ------------------- | ------- | ----------------------------- |
| nickname            | string  | null: false                   |
| email               | string  | null: false, uniqueness: true |
| encrypted_password  | string  | null: false                   |
| family_name         | string  | null: false                   |
| first_name          | string  | null: false                   |
| family_name_reading | string  | null: false                   |
| first_name_reading  | string  | null: false                   |
| birthday            | date    | null: false                   |

### Association

- has_many :items
- has_many :payments
- has_many :places

## itemsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| title           | string     | null: false                    |
| description     | text       | null: false                    |
| category_id     | string     | null: false                    |
| condition_id    | string     | null: false                    |
| postage_id      | integer    | null: false                    |
| send_from_id    | string     | null: false                    |
| shipment_day_id | string     | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :payment
- has_one :place

## paymentsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item            | references | null: false, foreign_key: true |
| card_number     | integer    | null: false                    |
| expiration_date | integer    | null: false                    |
| security_code   | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## placesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | integer    | null: false                    |
| prefecture_id | string     | null: false                    |
| city          | string     | null: false                    |
| block         | integer    | null: false                    |
| building      | string     |                                |
| phone_number  | integer    | null: false                    |
| item          | references | null: false, foreign_key: true |
| user          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item