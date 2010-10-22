require 'rest'
require 'json'

module Mine
  autoload :Attributes, 'mine/attributes'
  autoload :Gem,        'mine/gem'
  
  def self.fetch
    response = REST.get('http://rubygems.org/api/v1/search.json?query=cucumber')
    case response.status_code
    when 200
      JSON.parse(response.body)
    else
      raise RuntimeError, "Couldn't fetch gems for Gemcutter"
    end
  end
  
  def self.all
    fetch.map do |description|
      Mine::Gem.new(description)
    end
  end
end