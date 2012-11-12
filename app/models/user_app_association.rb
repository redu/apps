class UserAppAssociation < ActiveRecord::Base
  belongs_to :user
  belongs_to :app

  validates :user_id, uniqueness: { scope: :app_id }

  scope :filter, lambda { |filters|
    includes(app: :categories).where(app: { categories: { id: filters } })
  }
end
