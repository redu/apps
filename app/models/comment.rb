class Comment < ActiveRecord::Base
  attr_accessible :body, :author, :app, :type

  # Tipo de comentário: comum ou especializado (resenha)
  as_enum :type, :common => 0, :specialized => 1

  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :app

  validates_presence_of :author, :app, :body

  validates_length_of :body, :minimum => 1

  # Escopos que retornam comentários de especialistas e comentários de membros
  scope :specialized, where(type_cd: 1)
  scope :common, where(type_cd: 0)
end
