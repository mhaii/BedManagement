class ApplicationController < ActionController::Base
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  before_action :current_user

  def index
    render 'layouts/application'
  end

  protected
    def json_only
      prohibited unless params[:format] == 'json'
    end

    def xls_only
      prohibited unless params[:format] == 'xls'
    end

    def json_and_xls
      prohibited unless %w(json xls).include? params[:format]
    end

    def prohibited
      render text: 'Access Prohibited', status: 405
    end

    def error_not_found
      render json: { error: 'not found' }, status: 404
    end
end
