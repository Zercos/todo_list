class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid do |t|
      t.string :email, null: false
      t.string :auth_token, null: false
      t.string :address

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index :users, :auth_token, unique: true
  end
end
