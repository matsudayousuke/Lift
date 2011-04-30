class Tag < ActiveRecord::Base

  has_many :objective_tags

  has_many :objectives, :through => :objective_tags

end
