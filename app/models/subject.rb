class Subject < ActiveRecord::Base
  attr_accessible :name, :suid

  belongs_to :space
  has_many :lectures


  validates_presence_of :space, :name
end
