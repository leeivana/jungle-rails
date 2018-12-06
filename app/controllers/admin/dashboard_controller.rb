class Admin::DashboardController < ApplicationController
  @name = ENV['ADMIN_USERNAME']
  @password = ENV['ADMIN_PASSWORD']
  http_basic_authenticate_with name: @name, password: @password
  def show
  end
end
