class Api::UsersController < ApplicationController

  def index
    @users = User.all 
    render "index.json.jb"
  end

# def create
  
# end

# def show
  
# end

# def update
  
# end

# def destroy
  
# end

end
