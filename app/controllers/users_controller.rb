class UsersController < ApplicationController
  
  
  def index
    if client_has_valid_token?
      render json: User.all
    else
      require_login
    end
  end

  def show
    if client_has_valid_token?
    render json: User.find(params[:id])
  else
    require_login
  end
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
    if client_has_valid_token?
      @user = User.find(params[:id])
    if @user.update(user_params)
      render json: {message: "modification réussi !"}
    else
      render json: {message: "modification échouer !"}
    end
  else
    require_login
  end
    
  end

  def destroy
    if client_has_valid_token?
      User.find(params[:id]).destroy
    else
      require_login
    end
  end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
