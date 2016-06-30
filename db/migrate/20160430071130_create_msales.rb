class CreateMsales < ActiveRecord::Migration
  def change
    create_table :msales do |t|
      t.boolean :proforma
      t.string :customer
      t.string :nic
      t.string :address
      t.string :phone
      t.integer :total, limit: 8
      t.boolean :debt
      t.integer :tax
      t.boolean :delivery
      t.boolean :withdraw

      t.timestamps null: false
    end
  end
end
