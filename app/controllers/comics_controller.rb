# frozen_string_literal: true

# this controller represents the backend route of our turbo search
class ComicsController < ApplicationController
  def index
    @results = Comic
               .all
               .includes(:author)
  end

  def search
    @results = Comic
               .joins(:author)
               .includes(:author)
               .where(Comic.sanitize_sql_for_conditions(['comics.name LIKE ?', "%#{search_params[:search]}%"]))
               .or(
                 Author.where(
                   Author.sanitize_sql_for_conditions(['authors.name LIKE ?', "%#{search_params[:search]}%"])
                 )
               )
  end

  def create
    @comic = Comic.create(comic_params)
    @results = Comic
               .all
               .includes(:author)
  end

  private

  def search_params
    params.permit(:search)
  end

  def comic_params
    params
      .require(:comic)
      .permit(:name, :author_id)
  end
end
