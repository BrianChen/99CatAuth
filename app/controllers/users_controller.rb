class UsersController < ApplicationController
  before_action :redirect_to_main, only: [:new]

  def new

  end

  def index
    redirect_to new_user_url
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.save!
      login(user)
      redirect_to cats_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless session[:session_token] == @user.session_token
      redirect_to cats_url
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
