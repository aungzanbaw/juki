class CreateDeliveries < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.references :msale, index: true, foreign_key: true
      t.references :staff, index: true, foreign_key: true
      t.string :customer
      t.string :nic
      t.string :address
      t.string :phone

      t.timestamps null: false
    end
  end
end
