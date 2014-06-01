class CreatePeaks < ActiveRecord::Migration
  def change
    create_table :peaks do |t|
      t.string :name
      t.decimal :lat
      t.decimal :lng
      t.decimal :height
      t.string :geohash
      t.timestamps
    end
  end
end
