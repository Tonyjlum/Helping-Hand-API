class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :email
      t.string  :password
      t.string  :first_name
      t.string  :last_name
      t.integer :credit, :default => 0
      # t.string  :profile_pic, :default => "http://getdrawings.com/img/generic-person-silhouette-17.png"
      t.timestamps
    end
  end
end
