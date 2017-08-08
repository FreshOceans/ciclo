class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_gon_variable

  # GET /set_gon_variable
  def set_gon_variable
    puts "\n******** set_gon_variable ********"
    gon.js_presence = false
  end

end
