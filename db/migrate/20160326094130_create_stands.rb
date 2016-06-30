class CreateStands < ActiveRecord::Migration
  def change
    create_table :stands do |t|
      t.string :brand
      t.string :name
      t.integer :qty, limit: 8

      t.timestamps null: false
    end
  end
end
