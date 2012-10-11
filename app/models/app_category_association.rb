class AppCategoryAssociation < ActiveRecord::Base
  belongs_to :app
  belongs_to :category
end
