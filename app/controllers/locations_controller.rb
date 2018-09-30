class LocationsController < ApplicationController

  def index
    if params[:tags]
      @locations = Location.tagged_with(params[:tags])
    else 
      @locations = Location.all
	    @geojson = Array.new
	    @locations.each do |location|
  	    @geojson << {
          type: 'Feature',
          geometry: {
            type: 'Point',
            coordinates: [location.longitude, location.latitude]
          },
          properties: {
            name: location.name,
            :'marker-color' => '#00607d',
            :'marker-symbol' => 'circle',
            :'marker-size' => 'medium'
          }
        }
      end
      respond_to do |format|
     	  format.html
        format.json { render json: @geojson }  # respond with the created JSON object
      end
    end
  end

  def show
  	@location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end


  def create
   @location = Location.new(location_params)
     if @location.save
       redirect_to @location
     else
        render 'new'
     end
  end

  private

  def location_params
    params.require(:location).permit(:name, :longitude, :latitude, tag_ids: [])
  end 
end
