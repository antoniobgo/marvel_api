class AddUuidToComics < ActiveRecord::Migration[6.0]
  def change
    add_column :comics, :uuid, :integer
  end
end
