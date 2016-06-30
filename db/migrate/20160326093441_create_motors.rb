class CreateMotors < ActiveRecord::Migration
  def change
    create_table :motors do |t|
      t.string :brand
      t.string :name
      t.integer :watt
      t.integer :qty, limit: 8
      
      t.timestamps null: false
    end
  end
end
