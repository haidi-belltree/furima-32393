# テーブル設計

## usersテーブル

| Column        | Type    | Options     |
| ------------- | ------- | ----------- |
| nickname      | string  | null: false |
| email         | string  | null: false |
| password      | string  | null: false |
| name          | string  | null: false |
| name-reading  | string  | null: false |
| birthday      | integer | null: false |

### Association

- has_many :items
- has_many :buys

## itemsテーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| title       | string     | null: false                    |
| description | text       | null: false                    |
| price       | integer    | null: false                    |
| user        | references | null: false, foreign_key: true |
| category    | string     | null: false                    |
| condition   | string     | null: false                    |
| shipping    | string     | null: false                    |
| send-from   | string     | null: false                    |
| arrival     | string     | null: false                    |

### Association

- belongs_to :user
- has_one :buy

## buysテーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| item            | references | null: false, foreign_key: true |
| card-number     | integer    | null: false                    |
| expiration-date | integer    | null: false                    |
| security-code   | integer    | null: false                    |
| post-code       | integer    | null: false                    |
| prefecture      | string     | null: false                    |
| city            | string     | null: false                    |
| block           | integer    | null: false                    |
| building        | string     |                                |
| phone-number    | integer    | null: false                    |

### Association

- belongs_to :user
- belongs_to :item