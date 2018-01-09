class SessionsController < ApplicationController
  before_action :ensure_logged_out, only: [:new,:create]

  def new
  end

  def create
    user = User.find_by_credentials(user_params[:username], user_params[:password])
    if user
      session[:session_token] = user.session_token
      redirect_to user_url(user)
    else
      flash[:errors] = ["Incorrect username or password"]
      render :new
    end
  end

  def destroy
    user = User.find_by(id: params[:id])
    if user
      session.delete(:session_token)
      user.reset_session_token!
    end
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
