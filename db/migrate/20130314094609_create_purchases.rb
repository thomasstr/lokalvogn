class CreatePurchases < ActiveRecord::Migration
  def change
    create_table :purchases do |t|
      t.string :transaction_id
      t.string :cvv2_code
      t.string :avs_code
      t.decimal :amount
      t.string :token
      t.timestamps
    end
  end
end
