class UserEnvironmentAssociation < ActiveRecord::Base
  include BaseModel
  zombify

  attr_accessible :core_id

  belongs_to :user
  belongs_to :environment
end
