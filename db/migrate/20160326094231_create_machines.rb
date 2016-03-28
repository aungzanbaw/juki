class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :model
      t.string :series
      t.string :namemm
      t.string :nameeng
      t.text :description
      t.string :company
      t.integer :stock
      t.integer :qty

      t.timestamps null: false
    end
  end
end
