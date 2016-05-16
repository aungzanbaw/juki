class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.boolean :proforma
      t.references :staff, index: true, foreign_key: true
      t.string :customer
      t.string :address
      t.string :nic
      t.string :phone
      t.integer :cash
      t.integer :total
      t.boolean :postpone
      t.integer :tax

      t.timestamps null: false
    end
  end
end
