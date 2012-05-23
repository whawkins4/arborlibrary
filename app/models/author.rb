class Author < ActiveRecord::Base
  has_many :books, :through=>:authorships
  has_many :authorships
  
  def self.autocomplete(term)
    term = (term||'') + '%'
    sql = sanitize_sql(["select id, auth_last || ', ' || auth_first || ' ' || auth_middle as label from authors where auth_last ilike ?
    union 
    select id, auth_first || ' ' || auth_last as label from authors where auth_first ilike ?
    order by label",term, term])
    
    r = ActiveRecord::Base.connection.execute(sql)  
  end
end
