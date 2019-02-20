class CreateCharities < ActiveRecord::Migration[5.2]
  def change
    create_table :charities do |t|
      t.string :name
      t.string :discription
      t.integer :donations_received, :default => 0

      t.timestamps
    end
  end
end
