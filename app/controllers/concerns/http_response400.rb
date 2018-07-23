module HttpResponse400
  extend ActiveSupport::Concern

  def status_404(message = "Not Found.", errs = [])
    json_response({
      code: 404,
      message: message,
      errors: errs
    }, 404)
  end
  
  def status_422(message = "Validation failed.", errs = [])
    json_response({
      code: 422,
      message: message,
      errors: errs
    }, 422)
  end
end