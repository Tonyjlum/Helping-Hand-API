class CreateDonations < ActiveRecord::Migration[5.2]
  def change
    create_table :donations do |t|
      t.integer :event_id
      t.integer :sponsor_id
      t.integer :amount_per_volunteer
      t.timestamps
    end
  end
end
