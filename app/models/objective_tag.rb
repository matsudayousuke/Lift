class ObjectiveTag < ActiveRecord::Base

  belongs_to :objective
  
  belongs_to :tag

end
