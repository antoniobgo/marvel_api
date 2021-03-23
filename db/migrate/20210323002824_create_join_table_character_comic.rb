class CreateJoinTableCharacterComic < ActiveRecord::Migration[6.0]
  def change
    create_join_table :characters, :comics do |t|
      t.index [:character_id, :comic_id]
      t.index [:comic_id, :character_id]
    end
  end
end
