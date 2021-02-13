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

## paymentsテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item            | references | null: false, foreign_key: true |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :place

## placesテーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture_id | string     | null: false                    |
| city          | string     | null: false                    |
| block         | integer    | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |
| payment       | references | null: false, foreign_key: true |

### Association

- belongs_to :payment