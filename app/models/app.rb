class App < ActiveRecord::Base
  attr_accessible :name, :thumbnail

  validates_presence_of :name, :author, :language

  has_many :comments

  has_attached_file :thumbnail, :styles => { :medium => "300x300>", 
                                             :thumb => "100x100>" }

  has_and_belongs_to_many :users
end
