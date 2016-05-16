class CreateWithdraws < ActiveRecord::Migration
  def change
    create_table :withdraws do |t|
      t.references :msale, index: true, foreign_key: true
      t.references :staff, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
