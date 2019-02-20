class CreateCreditReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_receipts do |t|
      t.integer :user_id
      t.integer :charity_id
      t.integer :donations_amount
      t.timestamps
    end
  end
end
