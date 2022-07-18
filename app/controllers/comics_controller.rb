# frozen_string_literal: true

# this controller represents the backend route of our turbo search
class ComicsController < ApplicationController
  def index
    @results = all_comics
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
    @results = all_comics
  end

  def destroy
    comic = Comic.find(params[:id])
    comic.destroy!
  rescue ActiveRecord::RecordNotFound
    @error = I18n.t('.record_not_found')
  rescue ActiveRecord::RecordNotDestroyed
    @error = I18n.t('.record_not_destroyed')
  ensure
    @results = all_comics
  end

  private

  def search_params
    params.permit(:search)
  end

  def comic_params
    params
      .require(:comic)
      .permit(:id, :name, :author_id)
  end

  def all_comics
    Comic.includes(:author)
  end
end
