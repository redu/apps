class Subject < ActiveRecord::Base
  include BaseModel
  zombify

  attr_accessible :name, :suid, :space

  belongs_to :space
  has_many :lectures


  validates_presence_of :space, :name
end
