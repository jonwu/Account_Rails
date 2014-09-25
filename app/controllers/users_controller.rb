class UsersController < ApplicationController
  
  def index
  	@user = User.new
    @message = User::DEFAULT
  end

  def add
    user = params[:user]
    password = params[:password]
    
    @username = User.add(user,password)
    if @username.valid?
      render :json => { :password => @username.password, :username => @username.user}
    else
      if @username.errors.messages[:user] == ["-3"]
        render :json => User::ERR_BAD_USERNAME
      elsif @username.errors.messages[:password] == ["-4"]
        render :json => User::ERR_BAD_PASSWORD
      elsif @username.errors.messages[:user] == ["-2"]
        render :json => User::ERR_USER_EXISTS
      else
        render :json => @username.errors.messages
      end
    end
  end

  def login
    @username = User.login(params[:user], params[:password])
    if @username != nil
      render :json => { :error => User::SUCCESS, :count => @username.count}
    else
      render :json => User::ERR_BAD_CREDENTIALS
    end
  end

  def logout
    render 'index'
  end
    
    
    
  
end
