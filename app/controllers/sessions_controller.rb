class SessionsController < ApplicationController

  def create
    user = User.find_by("lower(email) = ?", user_params[:email])
    if user && user.authenticate(user_params[:password])
      render json: { token: 'Bearer ' + token(user.id, user.name, user.email, user.admin)}, status: :created 
    else 
      render json: { errors: [ "Sorry, incorrect email or password" ] }, status: :unprocessable_entity
    end 
  end

  private 
  def user_params
    params.require(:user).permit(:email, :password)
  end

end
