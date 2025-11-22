class UpdateShowsTable < ActiveRecord::Migration[8.0]
  def change
    rename_column :shows, :channel, :channel_name
    rename_column :shows, :name, :show_name

    add_column :shows, :channel_number, :integer
    add_column :shows, :available_on, :string

    change_column_null :shows, :show_name, false
    change_column_null :shows, :channel_name, false
  end
end
