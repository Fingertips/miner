class GemsController < ApplicationController
  def index
    @gems = Mine.all
  end
end
