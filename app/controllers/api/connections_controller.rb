class Api::ConnectionsController < ApplicationController

  # before_action :authenticate_user

  def index
    @connections = current_user.connections.all   
    render "index.json.jb"
  end

  def create
    @connection = Connection.new(
      user_id: current_user.id, 
      sender_id: params[:sender_id],
      recipient_id: params[:recipient_id],
      status: "Connection pending approval"
    )
    if @connection.save
      render "show.json.jb"
    else
      render json: { errors: @connection.errors.full_messages }, status: 422
    end
  end

  def update
    @connection = Connection.find(params[:id])

    # something... current user id, sender id, recipient id, and accepted

    if @connection.save 
      render "show.json.jb"
    else
      render json: { errors: @connection.errors.full_messages }, status: 422
    end
  end

  def destroy
    connection = current_user.connections.find(params[:id])
    connection.status = "removed"
    connection.save
    render json: { status: "You have removed this person from your connections"}
  end


end
