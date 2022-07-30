# frozen_string_literal: true

# add unique index database wise
class AddUniqueIndexToComics < ActiveRecord::Migration[7.0]
  def change
    add_index :comics, %i[name author_id], unique: true
  end
end
