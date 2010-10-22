module Mine
  class Gem
    DISQUALIFIED    = 0.0
    USED_TOO_MUCH   = 3000
    USED_TOO_LITTLE = 200
    
    include Attributes
    
    def authors
      @attributes['authors'].split(',')
    end
    
    def score
      if @attributes['downloads'].blank? or
         @attributes['downloads'].zero? or
         @attributes['downloads'] > USED_TOO_MUCH
        DISQUALIFIED
      elsif @attributes['downloads'] < USED_TOO_LITTLE
        @attributes['version_downloads'].to_f / 100
      else
        @attributes['version_downloads'].to_f / @attributes['downloads']
      end
    end
  end
end