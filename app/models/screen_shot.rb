class ScreenShot < ActiveRecord::Base
  attr_accessible :screen

  # App à qual o screen shot pertence
  belongs_to :app

  # Imagem do screenshot
  has_attached_file :screen
end
