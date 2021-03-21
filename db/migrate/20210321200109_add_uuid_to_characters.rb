class AddUuidToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :uuid, :integer
  end
end
