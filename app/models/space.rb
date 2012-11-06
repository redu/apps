class Space < ActiveRecord::Base
  zombify

  attr_accessible :name, :sid, :course

  # Associações
  belongs_to :course
  has_many :subjects

  # Validadores
  validates_presence_of :sid, :name, :course
  validates_uniqueness_of :sid
end
