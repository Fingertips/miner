class GemsController < ApplicationController
  def index
    @rocks = Rock.hottest
  end
end
