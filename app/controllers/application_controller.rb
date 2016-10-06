class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def verify_ownership
    unless current_user.cats.exists?(id: params[:id])
      redirect_to cats_url
    end
  end

  def redirect_to_main
    redirect_to cats_url  if current_user
  end

  def current_user
    @user ||= User.find_by(session_token: session[:session_token])
  end

  def login(user)
    session[:session_token] = user.session_token
    Session.create!(
    user_id: user.id, session_token: session[:session_token],
    device_type: request.env["HTTP_HOST"], ip_address: request.remote_ip)
  end

  def logout(user)
    # user.reset_session_token!
    session = user.sessions.find_by(session_token: session[:session_token])
    session.reset_session_token!
    session[:session_token] = nil
  end
end
