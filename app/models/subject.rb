class Subject < ActiveRecord::Base
  zombify

  attr_accessible :name, :suid, :space

  belongs_to :space
  has_many :lectures


  validates_presence_of :space, :name
end
