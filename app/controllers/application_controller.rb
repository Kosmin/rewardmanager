class ApplicationController < ActionController::API
  # Ensure `current_user` is available in controllers
  include Devise::Controllers::Helpers

  before_action :authenticate_user!
end
