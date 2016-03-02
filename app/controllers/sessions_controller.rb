class SessionsController < ApplicationController
  include SessionsHelper
  before_action :json_only, only: :current

  def create
    if (user = User.find_by(username: params[:sessions][:username]))
      if user.authenticate(params[:sessions][:password])
        log_in user
        params[:sessions][:remember_me] == '1' ? remember(user) : forget(user)
      else
        flash[:danger] = 'INCORRECT_PASSWORD'
      end
    else
      flash[:danger] = 'INCORRECT_USERNAME'
    end
    redirect_to root_url
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def current
    current_user
    render json: @current_user ? {username: @current_user.username, role: @current_user.role} : {}
  end
end