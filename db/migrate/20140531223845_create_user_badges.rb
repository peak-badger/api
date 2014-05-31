class CreateUserBadges < ActiveRecord::Migration
  def change
    create_table :user_badges do |t|
      t.belongs_to :user, null: false
      t.belongs_to :badge, null: false
      t.timestamps
    end

    add_index :user_badges, [:user_id, :badge_id], unique: true
  end
end
