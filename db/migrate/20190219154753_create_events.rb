class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :coordinator_id
      t.datetime :datetime
      t.string :title
      t.integer :max_volunteers
      t.string :address
      t.string :description
      t.float :lat
      t.float :long
      t.timestamps
    end
  end
end
