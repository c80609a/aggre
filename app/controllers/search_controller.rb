class SearchController < ApplicationController

  def search
    @query   = params[:query]
    @subj    = params[:subj]
    @results = Search.find(@query, @subj) if @query.present?
  end

end
