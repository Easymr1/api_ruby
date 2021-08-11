class UsersController < ApplicationController

  def index
    render json: User.all
  end
  
  def show
    render json: User.find(params[:id])
  end
  
  def new
    @user = User.new
  end

  def create
    
    @user = User.new(user_params)
    if @user.save
      render json: {message: "réussi"}
    else
      render json: {message: "echec"}
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
