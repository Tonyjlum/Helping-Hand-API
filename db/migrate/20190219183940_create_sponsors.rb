class CreateSponsors < ActiveRecord::Migration[5.2]
  def change
    create_table :spons0rs do |t|
      t.string  :email
      t.string  :password
      t.string  :first_name, :default => "Anonymous Donor"
      t.string  :last_name, :default => ""
      t.integer :credit, :default => 0
      t.integer :total_donations, :default => 0
      t.timestamps
    end
  end
end
