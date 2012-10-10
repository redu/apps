class App < ActiveRecord::Base
  attr_accessible :name
  has_many :app_category_associations, :dependent => :destroy
  has_many :categories, :through => :app_category_associations
end
