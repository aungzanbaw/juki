class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.references :msale, index: true, foreign_key: true
      t.integer :amount
      t.date :date
      t.boolean :paid

      t.timestamps null: false
    end
  end
end
