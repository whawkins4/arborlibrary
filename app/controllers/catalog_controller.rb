class CatalogController < ApplicationController
  skip_before_filter :authorize

  def index
    @title = "Search"
    @books = Book.paginate :page=>params[:page], :per_page => 15, :order => 'dewey, cutter'
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

end
