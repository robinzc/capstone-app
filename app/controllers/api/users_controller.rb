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
    @user.image_url = params[:image_url] || @user.languages_spoken

    if @user.save
      render "show.json.jb"
    else
      render json: { errors: @user.errors.full_messages }, status: 422
    end

  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "You have successfully deleted your account."}
  end

end
