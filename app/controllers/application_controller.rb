class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
  include HttpResponse400
  
  def current_user
    auth = request.headers['Authorization']
    @current_user ||= User.find(auth) if auth
  end

  def authorize
    redirect_to '/login' unless current_user
  end
end
