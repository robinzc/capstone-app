class Api::UsersController < ApplicationController

  def index
    @users = User.all 
    render "index.json.jb"
  end

  def create
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation],
      languages_spoken: params[:languages_spoken],
      image_url: params[:image_url]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render "show.json.jb"
  end

  def update
    @user = User.find(params[:id])

    @user.first_name = params[:first_name] || @user.first_name
    @user.last_name = params[:last_name] || @user.last_name
    @user.email = params[:email] || @user.email
    @user.languages_spoken = params[:languages_spoken] || @user.languages_spoken
    @user.image_url = params[:image_url] || @user.image_url

    if @user.save
      # remove all old user_city associations, make  brand new ones
      @user.user_cities.destroy_all
      # params[:city_associations] = [{city_id: 4, visited: true}, {city_id: 3, current_living: true}, {city_id: 7, lived: true}]
      # remove eval for frontend (it's for insomnia stringified array)
      eval(params[:city_associations]).each do |city_association|
        UserCity.create(
          user_id: current_user.id, 
          city_id: city_association[:city_id],
          visited: city_association[:visited] || false,
          lived: city_association[:lived] || false,
          current_living: city_association[:current_living] || false,
          current_visiting: city_association[:current_visiting] || false
        )
      end
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end

  end

  def destroy
    user = User.find(params[:id])
    user.connections.destroy_all
    user.destroy
    render json: { message: "You have successfully deleted your account."}
  end

end
