class BooksController < ApplicationController
  skip_before_filter :authorize, :only=>[:show]
  before_filter :find_book, :only=>[:card, :show, :edit, :update, :destroy]

  def card

  end
  #def isbn
  # sample of making a different "action" that reuses one of our other views
  #  @book = Book.find_by_isbn(params[:id])
  #  render :template=>'books/show'
  #end
  # GET /books
  # GET /books.json
  def index
    @title = "List Books"
    @books = Book.paginate :page=>params[:page], :per_page => 100, :order => 'title'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @title = "Show Book"

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @title = "New Book"
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @title = "Edit Book"

  end

  # POST /books
  # POST /books.json
  def create
    @title = "Create New Book"

    process_publisher

    all_book_params= params[:book]

    @book = Book.new(params[:book])

    process_authors

    process_subjects

    respond_to do |format|
      if @book.save
        format.html { redirect_to edit_book_path(@book), notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update    
    @title = "Edit Book"

    process_publisher

    process_authors

    process_subjects
    
    bookParams = params[:book]

    params.each {|key, value| 
      if key.match(/remove_authorship_/) 
        if value == "on"
          authorship_id = key.split('_')[2]
          authorship = Authorship.find(authorship_id)        
          authorship.destroy if authorship
        end
      elsif key.match(/remove_subject_/)
        subject_id = key.split('_')[2]
        subject = Subject.find(subject_id)
        @book.subjects.delete(subject) if subject
      end
    }
    respond_to do |format|
      if @book.update_attributes(bookParams)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @title = "Destroy Book"

    #    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :ok }
    end
  end


  private
  def find_book
    @book = Book.find_by_accession(params[:id])
    if @book.nil?
      @book = Book.find_by_isbn(params[:id])
    end    
    if @book.nil?
      @book = Book.find(params[:id])
    end
  end

  def process_publisher

    bookParams = params[:book]

    pub_name = params[:publisher_name]
    pub_place = params[:publisher_place]

    publishers = Publisher.find_by_sql(['select * from publishers where pub_name = ? and pub_place = ?', pub_name, pub_place])

    if publishers.length==0 and !pub_name.blank?
      pub = Publisher.new
      pub.pub_name = pub_name
      pub.pub_place = pub_place
      pub.save!     
      bookParams[:publisher] = pub
    else      
      bookParams[:publisher] = publishers[0] if publishers.length>0
    end    
  end

  def process_authors
    params.each {|key, value| 
      if key.match(/new_author_id_/) 

        new_author_index = key.split('_')[3]
        new_author_id = value
        authorship = Authorship.new
        authorship.book = @book
        authorship.author_id = new_author_id
        authorship.authorship_type = params['new_authorship_type_' + new_author_index]
        authorship.save!
      end

    }    
  end

  def process_subjects
    params.each {|key, value| 
      if key.match(/new_subject_id_/) 


        new_subject_id = value

        subject = Subject.find(new_subject_id)
        if subject
          @book.subjects<<subject
        else
          puts "Hey didn't find subject"
        end
      end
    }    
  end

end
