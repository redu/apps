class Subject < ActiveRecord::Base
  attr_accessible :name, :suid

  belongs_to :space

  validates_presence_of :space, :name, :suid
  validates_uniqueness_of :suid
end
