class GemsController < ApplicationController
  def index
    @gems = gems
  end
  
  private
  
  def gems
    JSON.parse(File.read(Rails.root + 'test/fixtures/files/gems.json')).map do |description|
      Mine::Gem.new(description)
    end
  end
end
