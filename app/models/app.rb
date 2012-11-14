# encoding: utf-8

class App < ActiveRecord::Base
  attr_accessible :aid, :name, :thumbnail, :views, :url, :author, :language

  validates_presence_of :aid, :name, :author, :language

  validates_uniqueness_of :aid

  # Categorias
  has_many :app_category_associations, dependent: :destroy
  has_many :categories, through: :app_category_associations

  # Comentários
  has_many :comments, dependent: :destroy

  # Usuários que favoritaram o aplicativo
  has_many :user_app_associations, dependent: :destroy
  has_many :users, through: :user_app_associations

  # Aulas em que o aplicativo é usado
  has_many :lectures

  # Screen shots
  has_many :screen_shots

  # Thumbnail
  has_attached_file :thumbnail,
    ReduApps::Application.config.paperclip.merge({ styles: { large: "x160>",
                                                             medium: "x90",
                                                             small: "x32" }})

  # Rating
  has_reputation :rating, source: :user, aggregated_by: :average

  scope :filter, lambda { |filters|
    includes(:categories).where(categories: { id: filters })
  }

  searchable do
    text :name, :boost => 5.0
    text :author, :language, :objective, :synopsis, :description,
      :publishers, :submitters, :copyright
    text :categories do
      categories.map(&:name)
    end
    integer :category_ids, multiple: true do
      categories.map(&:id)
    end
  end

  def self.favorited_by(apps, user)
    apps.collect(&:user_app_associations).flatten.
      select { |a| a.user_id == user.id }
  end
end
