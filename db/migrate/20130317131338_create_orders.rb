class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :ip_address
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.integer :zip_code
      t.string :country
      t.string :card_type
      t.date :card_expires_on

      t.timestamps
    end
  end
end
