class Course < ActiveRecord::Base
  attr_accessible :cid, :name, :owner, :environment

  # Associações
  belongs_to :owner, class_name: 'User', foreign_key: 'user_id'

  belongs_to :environment

  has_many :user_course_associations, :dependent => :destroy
  has_many :users, :through => :user_course_associations

  has_many :spaces
  # Validadores
  validates_presence_of :cid, :name, :owner, :environment
  validates_uniqueness_of :cid
end
