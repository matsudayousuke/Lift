class Objective < ActiveRecord::Base
  validates :name, :presence => true,
				   :length => {:maximum => 100}

end
