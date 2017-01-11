class AirImportsController < ApplicationController
  def create
    @import = AirImport.new(air_import_params)
    @import.user = current_user
    @import.process_in_background if @import.save
    respond_with @import
  end

  def new
    @import = AirImport.new
  end

  def show
    @import = AirImport.find(params[:id])
    return render(partial: params[:partial]) if params[:partial].present?
    respond_with @import
  end

  private

  def air_import_params
    params.require(:air_import).permit!
  end
end
