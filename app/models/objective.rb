class Objective < ActiveRecord::Base

  belongs_to :user

  validates :user_id, :presence => true

  validates :name, :presence => true, :length => {:maximum => 100}

  def self.search
    order("`order` desc").all
  end

end
