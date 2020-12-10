class ApplicationController < ActionController::Base
  # current_memberをテンプレートでも使えるようにする
  helper_method :current_member

  # 独自エラーを定義
  class LoginRequired < StandardError; end

  class Forbidden < StandardError; end

  private

  def current_member
    Member.find_by(id: session[:member_id]) if session[:member_id]
  end

  def login_required
    raise LoginRequired unless current_member
  end
end
