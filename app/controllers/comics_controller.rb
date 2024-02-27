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
    if @comic.save
      head :ok
    else
      @error = @comic.errors.full_messages.to_sentence
      head :unprocessable_entity
    end
    @results = Comic.with_author
  end

  def destroy
    comic = Comic.find_by(id: params[:id])
    @results = Comic.with_author
    if comic.destroy
      head :ok
    else
      @error = I18n.t('.record_not_found')
      head :unprocessable_entity
    end
  end

  private

  def search_params
    params.permit(:search, :authenticity_token)
  end

  def comic_params
    params.require(:comic).permit(:id, :name, :author_id)
  end
end
