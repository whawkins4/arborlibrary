require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  
  test "search" do 
    Book.search('Africa')
    
    puts "hello"
  end
end
