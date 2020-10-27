class Api::CitiesController < ApplicationController

  def index
    @cities = City.all
    render "index.json.jb"
  end

  # Temporary for easy data entry only:
  # def create
  #   city = City.new(
  #     name: params[:name],
  #     country: params[:country]
  #     latitude: params[:latitude]
  #     longitude: params[:longitude]
  #   )
  #   if city.save
  #     render json: { message: "City created successfully" }, status: :created
  #   else
  #     render json: { errors: city.errors.full_messages }, status: :bad_request
  #   end
  # end

  # def update
  #   @city = City.find(params[:id])

  #   @city.longitude = params[:longitude] || @city.longitude
  
  #   if @city.save
  #     render "show.json.jb"
  #   else
  #     render json: { errors: @city.errors.full_messages }, status: 422
  #   end
  # end

  # Update is temporary to fix data errors
end
