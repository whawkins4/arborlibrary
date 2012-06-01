class ApplicationController < ActionController::Base
  before_filter :check_for_user
  before_filter :authorize
  protect_from_forgery
  
protected

  #this before filter is run before pretty much EVERY request even if authorization is not required 
  #because we will still want to give known admin users more options even on the public requests
  def check_for_user
  
    @user = nil
    user_id = session[:user_id]
    @user = User.find_by_id(user_id) if user_id
  end
  
  #authorize controls requests that require admin rights and kicks them out if not
  def authorize
    #@user should have already been found in the check_for_user before_filter @user = User.find_by_id(session[:user_id])
    #return false #disable authentication for now while we're developing
    unless @user and @user.user_type == 'Admin'
      redirect_to login_url, :notice => "Please log in"
    end
  end
end