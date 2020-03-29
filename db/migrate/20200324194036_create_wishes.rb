class CreateWishes < ActiveRecord::Migration[6.0]
  def change
    create_table :wishes do |t|
      t.text :body
      t.string :url
      t.belongs_to :user
      t.timestamps
    end
  end
end
