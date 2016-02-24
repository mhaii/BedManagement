class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:sessions][:username])
    if user
      if user.authenticate(params[:sessions][:password])
        session[:user_id] = user.id
      else
        flash.now[:danger] = 'Incorrect password'
      end
    else
      flash.now[:danger] = 'Incorrect username'
    end
    redirect_to root_url
  end

  def destroy
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end
end