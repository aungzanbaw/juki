class CreateNeedles < ActiveRecord::Migration
  def change
    create_table :needles do |t|
      t.string :model
      t.string :category
      t.string :size
      # t.references :machine, index: true, foreign_key: true
      t.integer :stock, limit: 8
      t.integer :qty, limit: 8
      t.integer :price, limit: 8

      t.timestamps null: false
    end
  end
end
