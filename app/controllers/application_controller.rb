class ApplicationController < ActionController::Base
  # current_memberをテンプレートでも使えるようにする
  helper_method :current_member

  # 独自エラーを定義
  class LoginRequired < StandardError; end

  class Forbidden < StandardError; end

  # 例外処理
  if Rails.env.production? || ENV['RESCUE_EXCEPTIONS']
    rescue_from StandardError, with: :rescue_internal_server_error
    rescue_from ActiveRecord::RecordNotFound, with: :rescue_not_found
    rescue_from ActionController::ParameterMissing, with: :rescue_bad_request
  end

  rescue_from LoginRequired, with: :rescue_login_required
  rescue_from Forbidden, with: :rescue_forbidden

  private

  def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  def login_required
    raise LoginRequired unless current_member
  end

  # 例外処理用メソッド
  def rescue_bad_request(_exception)
    render 'errors/bad_request', status: 400, layout: 'error',
                                 formats: :html
  end

  def rescue_login_required(_exception)
    render 'errors/login_required', status: 403, layout: 'error',
                                    formats: :html
  end

  def rescue_forbidden(_exception)
    render 'errors/forbidden', status: 403, layout: 'error',
                               formats: :html
  end

  def rescue_not_found(_exception)
    render 'errors/not_found', status: 404, layout: 'error',
                               formats: :html
  end

  def rescue_internal_server_error(_exception)
    render 'errors/internal_server_error', status: 500, layout: 'error',
                                           formats: :html
  end
end
