require 'digest/sha2'

class User < ActiveRecord::Base
  #validates :name, :presence => true, :uniqueness => true
 
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader   :password
  validate  :password_must_be_present
  
  has_many :checkouts
  has_many :active_checkouts, :class_name=>'Checkout',:conditions=>['checked_in_on is null']

  
  def User.authenticate(name, password)
    if user = find_by_first(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end

  def name
    (first||'') + ' ' + (last||'')
  end
  def checked_out_books
    checkouts = self.active_checkouts 
    
    checkouts.map {|c| c.copy.book }
    
  end
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "wibble" + salt)
  end
  
  # 'password' is a virtual attribute
  def password=(password)
    @password = password

    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(password, salt)
    end
  end
  
  after_destroy :ensure_an_admin_remains
  
  def ensure_an_admin_remains
    if User.count.zero?
      raise "Can't delete last user"
    end
  end
  
  private

    def password_must_be_present
      errors.add(:password, "Missing password") unless hashed_password.present?
    end
  
    def generate_salt
      self.salt = self.object_id.to_s + rand.to_s
    end
end