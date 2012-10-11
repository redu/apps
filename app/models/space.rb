class Space < ActiveRecord::Base
  attr_accessible :name, :sid

  # Associações
  belongs_to :course

  # Validadores
  validates_presence_of :sid, :name, :course
  validates_uniqueness_of :sid
end
