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
      user = User.find_by("email = ?", user_params[:email])
      render json: { token: 'Bearer ' + token(user.id, user.name, user.email)}, status: :created 
    else
      render json: {message: "echec"}
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: {message: "modification réussi !"}
    else
      render json: {message: "modification échouer !"}
    end
  end

  def destroy
    User.find(params[:id]).destroy
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
