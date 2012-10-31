# encoding: utf-8

class Category < ActiveRecord::Base
  attr_accessible :name, :kind
  has_many :app_category_associations, dependent: :destroy
  has_many :apps, through: :app_category_associations, dependent: :destroy
  validates_presence_of :name, :kind

  scope :filter, lambda { |h = Hash.new(0)|
    where(kind: "Nível")
  }
end
