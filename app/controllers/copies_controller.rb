class CopiesController < ApplicationController

  # GET /copies
  # GET /copies.json
  #def index
  #  @title = "Copies"
  #  @copies = Copy.all

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @copies }
  #  end
  #end

  # GET /copies/1
  # GET /copies/1.json
  def show
    @title = "Show Copy"
    @copy = Copy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @copy }
    end
  end

  # GET /copies/new
  # GET /copies/new.json
  def new
    @title = "New Copy"
    @noheader = true;
    @copy = Copy.new

    book_id = params[:book_id]
    if book_id
    @book = Book.find(book_id)
  else
    @book = nil
    end
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @copy }
    end
  end

  # GET /copies/1/edit
  def edit
    @title = "Edit Copy"
    @copy = Copy.find(params[:id])
  end

  # POST /copies
  # POST /copies.json
  def create
    @title = "Create New Copy"


    #look for book_id
    book_id = params[:book_id]
    
    book = Book.find_by_id(book_id)
  
    @copy = Copy.new(params[:copy])
    
    @copy.catalog_date = Date.today.to_s if @copy.catalog_date.nil?

    @copy.book = book
    

      if @copy.save
        puts "helloooooo #{@copy.book.id}"
        redirect_to edit_book_path(@copy.book)
      else
        render :action=>:new
      end

  end

  # PUT /copies/1
  # PUT /copies/1.json
  def update
    @title = "Edit Copy"
    @copy = Copy.find(params[:id])

    respond_to do |format|
      if @copy.update_attributes(params[:copy])
        format.html { redirect_to edit_book_path(@copy.book), notice: 'Copy was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @copy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /copies/1
  # DELETE /copies/1.json
  def destroy
    @title = "Destroy Copy"
    @copy = Copy.find(params[:id])
    @book = @copy.book
    
    #note we're not actually giving users access to destroy records, we are "moving them to trash"
    #with a logical delete
    @copy.logical_delete

    respond_to do |format|
      format.html { redirect_to edit_book_path(@book) }
      format.json { head :ok }
    end
  end
end
