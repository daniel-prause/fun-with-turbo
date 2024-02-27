# frozen_string_literal: true

# This controller represents the backend route of our turbo search
class ComicsController < ApplicationController
  def index
    @results = Comic.with_author
  end

  def search
    @results = Comic.with_author
                    .with_search_term(search_params[:search])
  end

  def create
    @comic = Comic.new(comic_params)
    @error = @comic.errors.full_messages.to_sentence unless @comic.save
    @results = Comic.with_author
  end

  def destroy
    comic = Comic.find_by(id: params[:id])
    if comic
      comic.destroy
    else
      @error = I18n.t('.record_not_found')
    end
    @results = Comic.with_author
  end

  private

  def search_params
    params.permit(:search)
  end

  def comic_params
    params.require(:comic).permit(:id, :name, :author_id)
  end
end
