class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.string :brand
      t.string :name
      t.integer :width
      t.integer :height
      t.integer :qty, limit: 8
      
      t.timestamps null: false
    end
  end
end
