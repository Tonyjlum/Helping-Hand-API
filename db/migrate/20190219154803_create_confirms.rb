class CreateConfirms < ActiveRecord::Migration[5.2]
  def change
    create_table :confirms do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :attend, :default => false
      t.timestamps
    end
  end
end
