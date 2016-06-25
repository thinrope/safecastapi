class DashboardsController < ApplicationController
  def show
    return render 'home/show' unless current_user
    @unapproved_bgeigie_import_count =
      BgeigieImport.unapproved.count if current_user.moderator?
  end

  alias_method :new, :show
  alias_method :index, :show
end
