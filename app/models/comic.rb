# frozen_string_literal: true

class Comic < ApplicationRecord
  belongs_to :author
  after_create_commit lambda {
                        broadcast_append_to 'comics', locals: {
                                                        comic: self
                                                      },
                                                      target: 'comics'
                      }

  after_destroy_commit lambda {
                         broadcast_remove_to 'comics', target: self
                       }

  validates :name, presence: true, uniqueness: { scope: :author_id } # rubocop:disable Rails/UniqueValidationWithoutIndex
  scope :with_author, lambda {
    includes(:author)
  }
  scope :with_search_term, lambda { |term|
    joins(:author)
      .where(Comic.sanitize_sql_for_conditions(['comics.name LIKE ?', "%#{term}%"]))
      .or(
        Author.where(
          Author.sanitize_sql_for_conditions(['authors.name LIKE ?', "%#{term}%"])
        )
      )
  }
end
