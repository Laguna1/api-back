class ApplicationController < ActionController::API
  include ActionController::Helpers
  include ::ActionController::Cookies
  include Response
  include ExceptionHandler
end
