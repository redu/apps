class User < ActiveRecord::Base
  attr_accessible :login

  # Atributos de usuário Redu
  validates_presence_of :uid, :login, :first_name, :last_name, :role
  validates_uniqueness_of :uid, :login
  validates_length_of :login, :minimum => 5, :maximum => 20

  # Role (especialista / membro)
  as_enum :role, :specialist => 0, :member => 1

  # Aplicativos do usuário
  has_and_belongs_to_many :apps

  # Comentários
  has_many :comments
end
