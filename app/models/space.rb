class Space < ActiveRecord::Base
  include Zombificator::ActAsZombie

  act_as_zombie

  attr_accessible :name, :core_id, :course

  # Associações
  belongs_to :course
  has_many :subjects

  # Validadores
  validates_presence_of :core_id, :name, :course
  validates_uniqueness_of :core_id
end
