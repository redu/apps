class Comment < ActiveRecord::Base
  attr_accessible :body, :author, :app, :type

  # Tipo de comentário: comum ou especializado (resenha)
  as_enum :type, common: 0, specialized: 1, answer: 2

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :app
  belongs_to :in_response_to, class_name: 'Comment'

  has_many :answers, class_name: 'Comment', foreign_key: 'in_response_to_id',
    dependent: :destroy

  validates_presence_of :author, :app, :body

  validates_length_of :body, minimum: 2

  # Escopos que retornam comentários de especialistas e comentários de membros
  scope :specialized, where(type_cd: 1)
  scope :common, where(type_cd: 0)
  scope :answer, where(type_cd: 2)

  def self.get_by_type(app, type)
    app.comments.select { |c| c.type == type }
  end
end
