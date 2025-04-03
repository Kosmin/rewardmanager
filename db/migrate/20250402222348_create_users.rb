class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
      t.integer :points_balance, null: false, default: 0
      t.boolean :admin, null: false, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
