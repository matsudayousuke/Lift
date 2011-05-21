class Result < ActiveRecord::Base

  belongs_to :objective

  validates :body, :length => {:maximum => 4000}
  
end
