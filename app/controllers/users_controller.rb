class UsersController < ApplicationController
  def new
    render :json => {message: "New User"}
  end
end
