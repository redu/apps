class Answer < Comment
  belongs_to :in_response_to, class_name: 'Comment'

  validates_presence_of :in_response_to
end
