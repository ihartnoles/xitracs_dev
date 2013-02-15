require 'net/ldap'

class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => { :case_sensitive => false } 

  belongs_to :group
  belongs_to :department
  belongs_to :school
	has_many	:reasons

  before_create :set_defaults
 
  def User.authenticate(name, password)

    return nil if password.nil? || password.length == 0
    
    username = "fau\\" + name
    ldap = Net::LDAP.new( {:host => 'bocdcfau02.ad.fau.edu',
                       :port => 389,
                       :auth => { :method => :simple,
                                  :username => username,
                                  :password => password }})
    if (ldap.bind)
      # User/Pass Auth Succeeded. Now Try and find the user in our database 
      logger.error("Authenticated [#{username}] with valid password.")
      if ((user = User.find_by_name(name)) == nil) then
        logger.error("[#{username}] NOT Found in Database. Returning NIL")
      else
        logger.error("[#{username}] Found in Database.")
      end
    end
    return user
  end
  
  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def set_defaults    
      self.school_id = School.find(:first).id if self.school_id.nil?
      self.department_id = Department.find(:first).id if self.department_id.nil?
    end
end
