class UsersController < ApplicationController
  before_action :json_only

  def create
    @user = User.new(get_request_body)

    respond_to do |format|
      if @user.save
        format.json { render json: {'status': 'Success'} }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def get_request_body
    JSON.parse(request.body.string)
  end
end
