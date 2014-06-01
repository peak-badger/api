class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :fb_id, :bigint, null: false, unique: true
      t.timestamps
    end
  end
end
