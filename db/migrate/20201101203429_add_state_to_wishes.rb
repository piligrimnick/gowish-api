class AddStateToWishes < ActiveRecord::Migration[6.0]
  def change
    add_column :wishes, :state, :integer, null: false, default: 0
    add_index :wishes, :state
  end
end
