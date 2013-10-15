class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper

  protect_from_forgery
end
