class ApplicationController < ActionController::Base
  include Pundit
  include Redcarpet
  protect_from_forgery with: :exception
end
