class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.integer :burma
      t.integer :us

      t.timestamps null: false
    end
  end
end
