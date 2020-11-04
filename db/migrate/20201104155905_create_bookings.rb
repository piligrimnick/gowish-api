class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.bigint :user_id, null: false
      t.bigint :wish_id, null: false
      t.string :comment, null: true
      t.jsonb :meta, default: {}

      t.timestamps
    end

    add_index :bookings, :wish_id, unique: true
    add_index :bookings, [:user_id, :wish_id], unique: true
    add_foreign_key :bookings, :wishes, column: :wish_id
    add_foreign_key :bookings, :users, column: :user_id
  end
end
