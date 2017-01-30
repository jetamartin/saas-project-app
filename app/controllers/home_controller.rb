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
      @tenant = Tenant.current_tenant
      @projects = Project.by_plan_and_tenant(@tenant.id)
      params[:tenant_id] = @tenant.id
    end
  end
end
