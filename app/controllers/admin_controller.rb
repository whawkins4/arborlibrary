class AdminController < ApplicationController
  before_filter :authorize
  def index
    @title = "Admin Control Panel"
    @total_books = Book.count
    @total_act_books = Book.count
    @total_users = User.count
    @total_holds = Hold.count
    @total_checkouts = Checkout.outstanding_count
  end
  def list_checkouts 
    @title = "Outstanding Books"
      #todo add permission check to this admin function only
  #    @checkouts = Checkout.active_checkouts
       @checkout_data = Checkout.checkout_report_data
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @checkouts }
      end
  end
  def old_notes
    @books = Book.with_old_notes
  end
  def isbn_dups
    @books = Admin.books_with_dup_isbn
    @disable_pagination = true 
  end
  def title_dups
    @books = Admin.books_with_dup_title
    @disable_pagination = true
  end
  def authorless
    @books = Admin.authorless_books
  end
end
