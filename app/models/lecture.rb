class Lecture < ActiveRecord::Base
  attr_accessible :lectureable_id, :lectureable_type, :lid, :name

  # Associações
  belongs_to :subject
  belongs_to :app

  # Validadores
  validates_presence_of :name

  def self.create_via_api(params)
    conn = Connection.new(params[:token])
    conn.post(post_to_api_url(params[:subject_suid]),
              parse_lecture(params)) do |response, entity|
      lecture_href = entity['links'].detect {|l| l['rel'] == "self_link" }['href']
    end
  end

  def self.parse_lecture(params)
    { lecture: {
      name: params[:lecture_name], type: "Canvas",
      current_url: params[:url] }
    }.to_json
  end

  def self.post_to_api_url(subject_id)
    "/api/subjects/#{subject_id}/lectures"
  end
end
