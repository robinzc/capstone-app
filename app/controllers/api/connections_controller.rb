class Api::ConnectionsController < ApplicationController

  before_action :authenticate_user

  def index
    @connections = current_user.connections  
    render "index.json.jb"
  end

  # How can I prohibit more than 1 connection request being sent?
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

  # Needs work
  def update
    @connection = Connection.find(params[:id])
    if current_user.id == @connection.recipient.id
      @connection.accepted = params[:accepted] || @connection.accepted
      if @connection.save 
        render "show.json.jb"
      else
        render json: { errors: @connection.errors.full_messages }, status: 422
      end
    else
      render json: { errors: @connection.errors.full_messages }, status: 422
    end
  end

  def destroy
    connection = current_user.connections.find(params[:id])
    connection.save
    render json: { status: "You have removed this person from your connections"}
  end


end
