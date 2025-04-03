class CreateRewards < ActiveRecord::Migration[8.0]
  def change
    create_table :rewards do |t|
      t.string :name, null: false
      t.text :description
      t.float :price, null: false, default: 1.0
      t.datetime :expires_at

      t.timestamps
    end

    add_index :rewards, :name, unique: true
  end
end
