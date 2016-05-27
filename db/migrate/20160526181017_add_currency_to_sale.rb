class AddCurrencyToSale < ActiveRecord::Migration
  def change
    add_reference :sales, :currency, index: true, foreign_key: true
  end
end
