class Lecture < ActiveRecord::Base
  attr_accessible :lectureable_id, :lectureable_type, :lid, :name

  # Associações
  belongs_to :subject
  belongs_to :app

  # Validadores
  validates_presence_of :name, :subject

  def self.create_via_api(params)
    Connection.post post_to_api_url(params[:subject_suid]),
                    parse_lecture(params), params[:token]
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
