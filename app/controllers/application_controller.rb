class ApplicationController < ActionController::Base
  include Pundit
  include Redcarpet
  protect_from_forgery with: :exception
  before_action :authenticate_user!
end
