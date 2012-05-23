class Authorship < ActiveRecord::Base
  set_table_name "authors_books"
  belongs_to :book
  belongs_to :author
  
  #DANGER:  DO NOT REORDER THE AUTHORSHIP TYPES. THIS IS THE ONLY PLACE THAT THE SYSTEM DEFINES
  #WHAT EACH AUTHORSHIP TYPE CODE MEANS
  @@authorship_types = ['Author', 'Co-Author','Editor','Contributor','Illustrator']
  
  def self.authorship_types
    c = -1
    @@authorship_types.map {|t| c+=1
      [t, c]
      }
  end
  
  def authorship_type_in_words
    @@authorship_types[authorship_type||0]
  end
end
