class SearchController < ApplicationController
  skip_before_filter :authorize

  #auto_complete_for :recipe, :name
  
  def search
    @title = "Search Results"
    @copies = Copy.search(params[:search])
    
  end
end