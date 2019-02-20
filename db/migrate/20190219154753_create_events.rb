class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :coordinator_id
      t.datetime :datetime
      t.string :description
      t.timestamps
    end
  end
end
