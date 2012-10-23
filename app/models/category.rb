class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :app_category_associations, dependent: :destroy
  has_many :apps, through: :app_category_associations, dependent: :destroy
end
