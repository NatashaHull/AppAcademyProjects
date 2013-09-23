class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # this gives views access to helper methods
  include ApplicationHelper
end
