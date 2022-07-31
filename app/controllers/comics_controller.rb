# frozen_string_literal: true

# this controller represents the backend route of our turbo search
class ComicsController < ApplicationController
  def index
    @comics = Comic.with_author
                   .with_search_term(search_params[:search])
                   .order(name: :asc)
  end

  def create
    @comic = Comic.new(comic_params)
    return if @comic.save

    @error = @comic.errors.full_messages.to_sentence
  end

  def destroy
    comic = Comic.find(params[:id])
    return if comic.destroy

    @error = I18n.t('.record_not_destroyed')
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
end
