class AdminDashboardController < ApplicationController
  before_action :authenticate_admin!, only: [:index]

  layout "admin"

  def index
  end
end
