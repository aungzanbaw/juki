class CreatePurchaseDetails < ActiveRecord::Migration
  def change
    create_table :purchase_details do |t|
      t.references :purchase, index: true, foreign_key: true
      t.integer :stockable_id
      t.string :stockable_type
      t.integer :qty
      t.integer :price

      t.timestamps null: false
    end
    add_index :purchase_details, :stockable_id
    add_index :purchase_details, :stockable_type
  end
end
