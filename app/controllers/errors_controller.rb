class ErrorsController < ActionController::Base
  layout 'error'

  def show
    ex = request.env['action_dispatch.exception']   # 発生した例外を取得

    if ex.is_a?(ActionController::RoutingError)
      render 'not_found', status: 404, formats: :html
    else
      render 'internal_server_error', status: 500, formats: :html
    end
  end
end
