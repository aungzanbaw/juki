class CreateMsaleDetails < ActiveRecord::Migration
  def change
    create_table :msale_details do |t|
      t.references :msale, index: true, foreign_key: true
      t.integer :msaleable_id
      t.string :msaleable_type
      t.integer :qty
      t.integer :price

      t.timestamps null: false
    end
    add_index :msale_details, :msaleable_id
    add_index :msale_details, :msaleable_type
  end
end
