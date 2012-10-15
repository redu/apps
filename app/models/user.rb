class User < ActiveRecord::Base
  attr_accessible :login, :thumbnail

  # Atributos de usuário Redu
  validates_presence_of :uid, :login, :first_name, :last_name, :role
  validates_uniqueness_of :uid, :login
  validates_length_of :login, :minimum => 5, :maximum => 20

  # Role (especialista / membro)
  as_enum :role, :specialist => 0, :member => 1

  # Aplicativos do usuário
  has_many :user_app_associations, :dependent => :destroy
  has_many :apps, :through => :user_app_associations

  # Comentários
  has_many :comments

  # Thumbnail
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", 
                                             :thumb => "100x100>" }
end
