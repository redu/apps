class Course < ActiveRecord::Base
  include Untied::Consumer::Sync::Zombificator::ActsAsZombie

  attr_accessible :core_id, :name, :owner, :environment

  # Associações
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  belongs_to :environment

  has_many :user_course_associations, dependent: :destroy
  has_many :users, through: :user_course_associations

  has_many :spaces, dependent: :destroy
  # Validadores
  validates_presence_of :core_id, :name, :user_id
  validates_uniqueness_of :core_id
end
