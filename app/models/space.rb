class Space < ActiveRecord::Base
  include Untied::Zombificator::ActsAsZombie

  attr_accessible :name, :core_id, :course

  # Associações
  belongs_to :course
  has_many :subjects, dependent: :destroy

  # Validadores
  validates_presence_of :core_id, :name, :course_id
  validates_uniqueness_of :core_id
end
