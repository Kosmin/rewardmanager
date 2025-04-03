class CreateRedemptions < ActiveRecord::Migration[8.0]
  def change
    create_table :redemptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reward, null: false, foreign_key: true
      t.json :data

      t.timestamps
    end

    # Ensure one redemption per user
    add_index :redemptions, [ :user_id, :reward_id ], unique: true
  end
end
