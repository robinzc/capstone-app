class Api::UserCitiesController < ApplicationController

  before_action :authenticate_user

  def create
    @user_city = UserCity.new(
      user_id: current_user.id, 
      city_id: params[:city_id],
      visited: params[:visited],
      lived: params[:lived],
      current_living: params[:current_living],
      current_visiting: params[:current_visiting],
    )
    if @user_city.save
      render "show.json.jb"
    else
      render json: { errors: @user_city.errors.full_messages }, status: 422
    end
  end

  def update
    @user_city = UserCity.find(params[:id])

    @user_city.city_id = params[:city_id] || @user_city.city_id
    @user_city.visited = params[:visited] || @user_city.visited 
    @user_city.lived = params[:lived] || @user_city.lived
    @user_city.current_living = params[:current_living] || @user_city.current_living
    @user_city.current_visiting = params[:current_visiting] || @user_city.current_visiting

    if @user_city.save 
      render "show.json.jb"
    else
      render json: { errors: @user_city.errors.full_messages }, status: 422
    end

  end

  def destroy
    user_city = current_user.user_cities.find(params[:id])
    user_city.save
    render json: { status: "You have removed this city from your experiences"}
  end

end
