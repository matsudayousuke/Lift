class Objective < ActiveRecord::Base

  acts_as_taggable

  belongs_to :user

  has_many :results

  validates :user_id, :presence => true

  validates :name, :presence => true, :length => {:maximum => 100}

  def self.search
    order("`order`").all
  end

end
