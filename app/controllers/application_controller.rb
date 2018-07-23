class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include HttpResponse400
  
  def current_user
    auth = request.headers['Authorization']
    return nil unless auth
    @current_user ||= User.find(auth)
  end

  def authorize
    return status_404(nil, ["Header can't find the key: Authorization"]) unless current_user
  end
end
