class UserEnvironmentAssociation < ActiveRecord::Base
  include Zombificator::ActAsZombie

  act_as_zombie

  attr_accessible :core_id

  belongs_to :user
  belongs_to :environment
end
