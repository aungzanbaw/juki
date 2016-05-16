class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.integer :phone
      t.string :address
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
