class CreateParts < ActiveRecord::Migration
  def change
    create_table :parts do |t|
      t.string :model
      t.string :namemm
      t.string :nameeng
      t.text :description
      t.references :machine, index: true, foreign_key: true
      t.integer :stock, limit: 8
      t.integer :qty, limit: 8
      t.integer :price, limit: 8

      t.timestamps null: false
    end
  end
end
