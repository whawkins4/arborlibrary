class CheckoutsController < ApplicationController
  # GET /checkouts
  # GET /checkouts.json
  skip_before_filter :authorize

  def index 
    @title = "Check Out Books"
    @library_card = params["library_card"]
    if @library_card
      @user = User.find_by_library_card(@library_card)
    end
    #careful in the future that the ApplicationController.authorize is not setting the @user from the current
    #login, unless user requirements change and they want it to do that
    #for now we are skipping the authorize before_filter so that the checkout screen works the same way regardless
    #of login state
  end

  def checkin
        @title = "Check Out Books"
  end
  def process_checkin 
    begin

      accession = params[:accession]
      copy = Checkout.checkin(accession)
      if (copy)   
        msg = copy.title.gsub('"','')
      end
      msg = "Checkin of #{msg} Successful"
      success=true
    rescue Exception => e
      msg = e.message.gsub('"','').gsub('uncaught throw ','')
      msg = "Checkin Failed for accession #{accession}. #{msg}"
      success=false
    end
    render :json=>"{\"success\":\"#{success}\",\"msg\":\"#{msg}\"}"
  end

  # GET /checkouts/new
  # GET /checkouts/new.json
  def new

    @library_card = params["library_card"]
    if @library_card
      @user = User.find_by_library_card(@library_card)
    end

    if !@user
      flash[:notice]="Invalid or missing library card."
      @playErrorSound = true
      render :action=>:index 
      return 
    end

    flash[:notice]=nil
    @checkout = Checkout.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checkout }
    end
  end

  # POST /checkouts
  # POST /checkouts.json
  def create

    @library_card = params["library_card"]

    if @library_card
      @user = User.find_by_library_card(@library_card)
    end

    if @user
      accession = params[:accession]
      if accession.blank?
        flash[:notice] = "Hey there's no accession number."
        redirect_to :action=>:new, :library_card=>@library_card
        return
      else 
        begin 
          @checkout = Checkout.checkout_by_accession(accession,@user)  

        rescue Exception => e
          msg = e.message.gsub('"','').gsub('uncaught throw ','')
          flash[:notice] = "Checkout failed!  #{msg}"
          @playErrorSound = true
          redirect_to checkouts_path, notice: 'Checkout was NOT successful!!!'
          #redirect_to :action=>:new, :library_card=>@library_card
          return 
        end
      end
    else
      redirect_to :action=>:index
      return
    end

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to checkouts_path, notice: 'Checkout was successfully created.' }
        format.json { render json: @checkout, status: :created, location: @checkout }
      else
        format.html { redirect_to checkouts_path, notice: 'Checkout was NOT successful!!!' }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

end
