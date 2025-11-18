class AddUserToShows < ActiveRecord::Migration[8.0]
  def change
    add_reference :shows, :user, null: false, foreign_key: true
  end
end
