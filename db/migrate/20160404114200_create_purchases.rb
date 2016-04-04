class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :name
      t.string :address
      t.string :nic
      t.string :phone
      t.integer :total

      t.timestamps null: false
    end
  end
end
