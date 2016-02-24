class SessionsController < ApplicationController
  include SessionsHelper
  def create
    if (user = User.find_by(username: params[:sessions][:username]))
      if user.authenticate(params[:sessions][:password])
        log_in user
        params[:sessions][:remember_me] == '1' ? remember(user) : forget(user)
      else
        flash.now[:danger] = 'Incorrect password'
      end
    else
      flash.now[:danger] = 'Incorrect username'
    end
    redirect_to root_url
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end