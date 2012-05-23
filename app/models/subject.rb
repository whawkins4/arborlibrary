class Subject < ActiveRecord::Base
  has_and_belongs_to_many :books
  
  
  def self.autocomplete(term)
    puts "subject searching"
    term = (term||'') + '%'
    sql = sanitize_sql(["select id, subject as label from subjects where subject ilike ?
    order by label",term])
    
    r = ActiveRecord::Base.connection.execute(sql)  
  end
  
end
