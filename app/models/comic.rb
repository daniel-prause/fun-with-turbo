# frozen_string_literal: true

class Comic < ApplicationRecord
  belongs_to :author

  validates :name, presence: true, uniqueness: { scope: :author_id }
end
