class Subject < ActiveRecord::Base
  attr_accessible :suid, :name, :space

  belongs_to :space
  has_many :lectures

  validates_presence_of :space, :name

  def self.create_via_api(space_id, subject)
    Connection.post '/spaces/#{space_id}/subjects', subject.to_json
  end
end
