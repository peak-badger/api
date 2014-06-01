class CreateBadge < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.belongs_to :user
      t.belongs_to :peak
      t.timestamps
    end

    add_index :badges, [:user_id, :peak_id], unique: true
  end
end
