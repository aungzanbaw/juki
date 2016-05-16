class CreateSaleDetails < ActiveRecord::Migration
  def change
    create_table :sale_details do |t|
      t.references :sale, index: true, foreign_key: true
      t.integer :itemable_id
      t.string :itemable_type
      t.integer :qty

      t.timestamps null: false
    end
  end
end
