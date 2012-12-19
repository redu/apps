# encoding: utf-8

class App < ActiveRecord::Base
  attr_accessible :core_id, :name, :thumbnail, :views, :url, :author, :language

  validates_presence_of :core_id, :name, :author, :language, :core_url
  validates_uniqueness_of :core_id

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
  has_many :screen_shots, dependent: :destroy

  # Thumbnail
  has_attached_file :thumbnail,
    ReduApps::Application.config.paperclip.merge({ styles: { large: "x160#",
                                                             medium: "x90#",
                                                             small: "x32#" }})

  # Rating
  has_reputation :rating, source: :user, aggregated_by: :average
  MIN_RATING = 1
  MAX_RATING = 5

  scope :filter, lambda { |filters|
    includes(:categories).where(categories: { id: filters })
  }

  searchable do
    text :name, boost: 5.0
    text :author, :language, :objective, :synopsis, :description,
      :publishers, :submitters, :copyright
    text :categories do
      categories.map(&:name)
    end
    integer :category_ids, multiple: true do
      categories.map(&:id)
    end
  end


  def get_rating_by(user)
    self.evaluations.where(source_id: user.id, source_type: "User",
                           reputation_name: "rating").first.value
  end

  def self.favorited_by(apps, user)
    apps.collect(&:user_app_associations).flatten.
      select { |a| a.user_id == user.id }
  end

  def self.is_valid_rating_value?(value)
    value.between?(MIN_RATING, MAX_RATING)
  end
end
