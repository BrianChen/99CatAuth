class SessionsController < ApplicationController
  before_action :redirect_to_main, only: [:new]

  def new

  end

  def create
    user = User.find_by_credentials(
    session_params[:username], session_params[:password])
    if user
      user.reset_session_token!
      login(user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    user = current_user
    if user
      logout(user)
      redirect_to cats_url
    else
      redirect_to cats_url
    end
  end

  def show
    @user = User.find(params[:id])
    unless session[:session_token] == @user.session_token
      redirect_to cats_url
    end
  end

  private
  def session_params
    params.require(:user).permit(:username, :password)
  end
end
