class CreateComics < ActiveRecord::Migration[6.0]
  def change
    create_table :comics do |t|
      t.string :title
      t.string :description
      t.string :variantDescription
      t.integer :pageCount
      t.string :cover

      t.timestamps
    end
  end
end
