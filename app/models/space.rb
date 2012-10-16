class Space < ActiveRecord::Base
  attr_accessible :name, :sid

  # Associações
  belongs_to :course
  has_many :subjects

  # Validadores
  validates_presence_of :sid, :name, :course
  validates_uniqueness_of :sid
end
