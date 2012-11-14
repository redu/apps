class Lecture < ActiveRecord::Base
  attr_accessible :lectureable_id, :lectureable_type, :lid, :name

  # Associações
  belongs_to :subject
  belongs_to :app

  # Validadores
  validates_presence_of :name, :subject

  def self.create_via_api(params)
    Connection.post "/api/subjects/#{params[:subject_suid]}/lectures",
                    parse_lecture(params),
                    params[:token]
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
end
