class Rock < ActiveRecord::Base
  named_scope :hottest, { :order => 'score DESC', :limit => 20 }
  
  serialize :authors
end
