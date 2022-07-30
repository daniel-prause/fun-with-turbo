# frozen_string_literal: true

# this controller represents the backend route of our turbo search
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
    @comic.save!
  rescue StandardError
    @error = @comic.errors.full_messages.to_sentence
  end

  def destroy
    comic = Comic.find(params[:id])
    comic.destroy!
  rescue ActiveRecord::RecordNotFound
    @error = I18n.t('.record_not_found')
  rescue ActiveRecord::RecordNotDestroyed
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
