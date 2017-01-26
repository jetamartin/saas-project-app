class HomeController < ApplicationController
  # Doesn't require that the user be logged in to see the home page
  skip_before_action :authenticate_tenant!, :only => [ :index ]

  def index
    if current_user
      if session[:tenant_id]
        Tenant.set_current_tenant session[:tenant_id]
      else
        Tenant.set_current_tenant current_user.tenants.first
      end
      @tentant = Tenant.current_tenant
      params[:tenant_id] = @tenant.id
    end
  end
end
