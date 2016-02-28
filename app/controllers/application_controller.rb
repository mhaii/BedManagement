require 'slim/include'
class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action { current_user }

  def index
    render 'layouts/application' unless params[:format]
  end

  protected
    def json_only
      render text: 'Access Prohibited', status: 405 unless params[:format] == 'json'
    end
end
