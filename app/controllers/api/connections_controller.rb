class Api::ConnectionsController < ApplicationController

  before_action :authenticate_user

  def index
    @connections = current_user.connections  
    render "index.json.jb"
  end

  def create
    @connection = Connection.new(
      sender_id: current_user.id,
      recipient_id: params[:recipient_id],
      accepted: false
    )
    if @connection.save
      render "show.json.jb"
    else
      render json: { errors: @connection.errors.full_messages }, status: 422
    end
  end

  def update
    @connection = Connection.find(params[:id])
    if current_user.id == @connection.recipient.id
      @connection.accepted = true
      if @connection.save 
        render "show.json.jb"
      else
        render json: { errors: @connection.errors.full_messages }, status: 422
      end
    else
      render json: { errors: "You are not the connection recipient" }, status: 401
    end
  end

  def destroy
    connection = current_user.connections.find(params[:id])
    connection.destroy
    render json: { status: "You have removed this person from your connections"}
  end

  def map_connections
    @friends = current_user.accepted_friends
    render "map_connections.json.jb"    
  end


end
