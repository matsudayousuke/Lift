class Objective < ActiveRecord::Base

  belongs_to :user

  has_many :objective_tags

  has_many :tags, :through => :objective_tags

  validates :user_id, :presence => true

  validates :name, :presence => true, :length => {:maximum => 100}

  def self.search
    order("`order`").all
  end

end
