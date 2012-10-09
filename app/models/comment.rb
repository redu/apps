class Comment < ActiveRecord::Base
  attr_accessible :body, :author, :app

  belongs_to :author, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :app

  validates_presence_of :author, :app, :body

  validates_length_of :body, :minimum => 1

  # Escopos que retornam comentários de especialistas e comentários de membros
  scope :specialized, joins(:author).where('users.role_cd' => User.specialist)
  scope :common, joins(:author).where('users.role_cd' => User.member)
end
