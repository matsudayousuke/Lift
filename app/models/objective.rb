class Objective < ActiveRecord::Base
  validates :name, :presence => true,
				   :length => {:maximum => 100}

  def self.search
    order("'order' desc").all
  end

end
