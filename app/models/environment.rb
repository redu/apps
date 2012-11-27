class Environment < ActiveRecord::Base
  include Untied::Zombificator::ActAsZombie

  acts_as_zombie

  attr_accessible :core_id, :name, :zombie, :owner

  # Associações
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'

  has_many :user_environment_associations, :dependent => :destroy
  has_many :users, :through => :user_environment_associations

  has_many :courses

  # Validadores
  validates_uniqueness_of :core_id
  validates_presence_of :core_id, :name, :owner

  # Thumbnail
  has_attached_file :thumbnail,
    ReduApps::Application.config.paperclip.merge({styles: { medium: "300x300>",
                                                            thumb: "100x100>" }})
end
