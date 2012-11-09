class ScreenShot < ActiveRecord::Base
  attr_accessible :screen

  # App à qual o screen shot pertence
  belongs_to :app

  # Imagem do screenshot
  has_attached_file :screen,
    ReduApps::Application.config.paperclip.merge({styles: { unique: "700x200",
                                                            double: "340x200" }})
end
