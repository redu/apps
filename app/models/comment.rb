class Comment < ActiveRecord::Base
  attr_accessible :body, :author, :app, :kind

  # Tipo de comentário: comum ou especializado (resenha)
  as_enum :kind, common: 0, specialized: 1

  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :app
  belongs_to :in_response_to, class_name: 'Comment'

  has_many :answers, foreign_key: 'in_response_to_id', dependent: :destroy

  validates_presence_of :author, :app, :body

  validates_length_of :body, minimum: 2

  # Escopos que retornam comentários de especialistas e comentários de membros
  scope :specialized, where(kind_cd: 1)
  scope :common, where(kind_cd: 0)

  def self.get_by_kind(app, kind)
    app.comments.select { |c| c.kind == kind }
  end
end
