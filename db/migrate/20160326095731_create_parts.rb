class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :model
      t.string :namemm
      t.string :nameeng
      t.text :description
      t.references :machine, index: true, foreign_key: true
      t.integer :stock
      t.integer :qty
      t.integer :price

      t.timestamps null: false
    end
  end
end
