class SessionsController < ApplicationController
  before_action :json_only, only: :show

  def create
    data = {}
    respond_to do |format|
      format.html do
        data[:username]  = params[:sessions][:username]     || ''
        data[:password]  = params[:sessions][:password]     || ''
        data[:persist]   = params[:sessions][:remember_me]  || '0'
      end
      format.json do
        json = JSON.parse(request.body.string, symbolize_names: true)
        data[:username]  = json[:username]    || ''
        data[:password]  = json[:password]    || ''
        data[:persist]   = json[:remember_me] || '0'
      end
    end
    if (user = User.find_by(username: data[:username]))
      if user.authenticate(data[:password])
        log_in user
        data[:persist] == '1' ? remember(user) : forget(user)
      else
        data[:error] = 'INCORRECT_PASSWORD'
      end
    else
      data[:error]   = 'INCORRECT_USERNAME'
    end
    respond_to do |format|
      format.html do
        flash[:danger] = data[:error] if data[:error]
        redirect_to root_url
      end
      format.json do
        render json: {status: 'ok'} and return unless data[:error]
        render json: {error: data[:error]}, status: 401
      end
    end
  end

  def destroy
    log_out if logged_in?
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { render json: { status: 'success'}, status: 200 }
    end
  end

  def show
    render json: @current_user ? {username: @current_user.username, role: @current_user.role} : {username: 'guest', role: 'guest'}
  end
end