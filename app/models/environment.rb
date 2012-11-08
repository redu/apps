class Environment < ActiveRecord::Base
  attr_accessible :eid, :name

  # Associações
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'

  has_many :user_environment_associations, :dependent => :destroy
  has_many :users, :through => :user_environment_associations

  has_many :courses

  # Validadores
  validates_uniqueness_of :eid
  validates_presence_of :eid, :name, :owner

  # Thumbnail
  has_attached_file :thumbnail,
    styles: ReduApps::Application.config.paperclip.merge({ medium: "300x300>",
                                                           thumb: "100x100>" })
end
