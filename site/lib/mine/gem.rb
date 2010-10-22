module Mine
  class Gem
    include Attributes
    
    def authors
      @attributes['authors'].split(',')
    end
    
    def score
      0.1
    end
  end
end