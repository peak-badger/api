class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column  :fb_id, :bigint, null: false, unique: true
      t.decimal :vertical_height
      t.string  :first_name
      t.string  :last_name
      t.timestamps
    end
  end
end
