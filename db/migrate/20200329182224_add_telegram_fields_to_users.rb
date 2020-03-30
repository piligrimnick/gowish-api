class AddTelegramFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :telegram_id, :string, null: true
    add_column :users, :username, :string, null: true
    add_column :users, :firstname, :string, null: true
    add_column :users, :lastname, :string, null: true
    change_column_null :users, :email, true
    change_column_null :users, :encrypted_password, true
    remove_index :users, :email
    add_index :users, [:email, :telegram_id], unique: true
  end
end
