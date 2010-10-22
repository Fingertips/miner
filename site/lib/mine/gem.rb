module Mine
  class Gem
    include Attributes
    
    def authors
      @attributes['authors'].split(',')
    end
  end
end