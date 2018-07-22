module HttpResponse400
  extend ActiveSupport::Concern

  
  def status_422(message = "Validation failed.", errs = [])
    json_response({
      code: 422,
      message: message,
      errors: errs
    }, 422)
  end
end