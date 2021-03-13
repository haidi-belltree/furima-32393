class CreatePlaces < ActiveRecord::Migration[6.0]
  def change
    create_table :places do |t|
      t.string :post_code,      null: false, default: ""
      t.integer :prefecture_id, null: false
      t.string :city,           null: false
      t.string :block,          null: false
      t.string :building                   , default: ""
      t.string :phone_number,   null: false
      t.references :payment ,   null: false, foreign_key: true
      t.timestamps
    end
  end
end
