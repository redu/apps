class Subject < ActiveRecord::Base
  attr_accessible :suid, :name, :space

  belongs_to :space
  has_many :lectures

  validates_presence_of :space, :name

  def self.create_via_api(params)
    Connection.post "/spaces/#{ params[:space_id] }/subjects",
                    { subject: { name: params[:subject] } }, params[:token]
  end
end
