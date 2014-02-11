class PlacesController < ApplicationController

  def index
  end


  def show
  	@place = BeermappingApi.find_place(params[:id], session)

  	render :show
  end


  def search
    session[:city] = params[:city]
    #@last_city = session[:city]

  	@places = BeermappingApi.places_in params[:city]

  	if @places.empty?
  		redirect_to places_path, notice: "No locations in #{params[:city].capitalize}"
  	else
		render :index
	end
  end
end

