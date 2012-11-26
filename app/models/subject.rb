class Subject < ActiveRecord::Base
  include Zombificator::ActAsZombie

  act_as_zombie

  attr_accessible :name, :core_id, :space

  belongs_to :space
  has_many :lectures

  validates_presence_of :space, :name

  def self.create_via_api(params)
    conn = Connection.new(params[:token])
    conn.post(post_to_api_url(params[:space_sid]),
              parse_subject(params)) do |response, entity|
      Subject.new(name: entity['name'], core_id: entity['id'])
    end
  end

  def self.parse_subject(params)
    { subject: { name: params[:subject] } }.to_json
  end

  def self.post_to_api_url(space_id)
    "/api/spaces/#{space_id}/subjects"
  end
end
