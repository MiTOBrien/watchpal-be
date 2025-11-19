class CreateShows < ActiveRecord::Migration[8.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :air_day
      t.time :air_time
      t.string :channel

      t.timestamps
    end
  end
end
