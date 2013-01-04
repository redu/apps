class UserEnvironmentAssociation < ActiveRecord::Base
  include Untied::Consumer::Sync::Zombificator::ActsAsZombie

  attr_accessible :core_id

  belongs_to :user
  belongs_to :environment
end
