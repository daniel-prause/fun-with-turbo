# frozen_string_literal: true

class Comic < ApplicationRecord
  belongs_to :author

  # in an actual application, one would move these into a presenter
  after_create_commit lambda {
                        broadcast_append_to 'comics', locals: {
                                                        comic_row: self
                                                      },
                                                      target: 'comics'
                      }

  after_destroy_commit lambda {
                         broadcast_remove_to 'comics', target: self
                       }

  validates :name, presence: true, uniqueness: { scope: :author_id }
  scope :with_author, lambda {
    includes(:author)
  }
  scope :with_search_term, lambda { |term|
    return self if term.blank?

    joins(:author)
      .where(Comic.sanitize_sql_for_conditions(['comics.name LIKE ?', "%#{term}%"]))
      .or(
        Author.where(
          Author.sanitize_sql_for_conditions(['authors.name LIKE ?', "%#{term}%"])
        )
      )
  }
end
