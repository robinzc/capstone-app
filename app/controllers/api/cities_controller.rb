class Api::CitiesController < ApplicationController

  def index
    @cities = City.all
    render "index.json.jb"
  end


end
