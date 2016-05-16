class CreateChasses < ActiveRecord::Migration
  def change
    create_table :chasses do |t|
      t.references :msale, index: true, foreign_key: true
      t.references :msale_detail, index: true, foreign_key: true
      t.string :chassisnum

      t.timestamps null: false
    end
  end
end
