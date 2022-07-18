# frozen_string_literal: true

class CreateComics < ActiveRecord::Migration[7.0]
  def change
    create_table :comics do |t|
      t.string :name
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
