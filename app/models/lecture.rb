class Lecture < ActiveRecord::Base
  attr_accessible :lectureable_id, :lectureable_type, :lid, :name

  # Associações
  belongs_to :subject
  belongs_to :app

  # Validadores
  validates_presence_of :name, :subject

  def self.create_via_api(params)
    conn = Connection.new(params[:token])
    response = conn.post post_to_api_url(params[:subject_suid]),
                         parse_lecture(params)
    case response.status #TODO
    when 201
      lecture = JSON.parse response.body
      lecture_href = lecture['links'].detect {|l| l['rel'] == "self" }['href']
    when 401 # Permissão negada
      raise ActiveResource::UnauthorizedAccess.new(response)
    when 422 # Payload mal formatado
      raise ActiveResource::BadRequest.new(response)
    else
      raise "Unknown status code #{response.status}"
    end
  end

  def self.parse_lecture(params)
    { lecture: {
               name: params[:lecture], type: "Canvas",
               lectureable: {
                            client_application_id: params[:aid]
                            }
               }
    }.to_json
  end

  def self.post_to_api_url(subject_id)
    "/api/subjects/#{subject_id}/lectures"
  end
end
