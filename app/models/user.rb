class User < ActiveRecord::Base
	

	DEFAULT = "Please enter your credentials below"
	SUCCESS = 1
	ERR_BAD_CREDENTIALS = {"errCode" => -1, "message" =>"Cannot find the user/password pair in the database"}
	ERR_USER_EXISTS = {"errCode" => -2, "message" => "trying to add a user that already exists (for add only)"}
	ERR_BAD_USERNAME = {"errCode"=>-3, "message" =>"invalid user name (empty or longer than MAX_USERNAME_LENGTH)"}
	ERR_BAD_PASSWORD = {"errCode"=>-4, "message" =>"invalid password name (longer than MAX_PASSWORD_LENGTH)"}
	MAX_USERNAME_LENGTH = 128
	MAX_PASSWORD_LENGTH = 128

	validates :user, :presence => {:message =>"-3"}
	validates :user, :uniqueness => {:message => "-2"}
	validates :user, length: { maximum: MAX_USERNAME_LENGTH, message: "-3"}
	validates :password, length: {maximum: MAX_PASSWORD_LENGTH, message: "-4"}
	

	def self.getUser(user, password)
		username = User.where(user: user, password: password)
		user = username[0]
		return user
	end


	def self.add(user, password)
		username = User.new(:user => user, :password => password, :count => 1)
		username.save
		return username
	end

	def self.login(user, password)
		username = User.getUser(user,password)
	    if username != nil
	    	User.increment_counter :count, username.id
	    	username = User.getUser(user,password)
      end

	    return username
	    
	end

	def self.TESTAPI_resetFixture
		User.destroy_all
	end
end
