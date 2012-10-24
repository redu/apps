class App < ActiveRecord::Base
  attr_accessible :name, :thumbnail, :views

  validates_presence_of :name, :author, :language

  # Categorias
  has_many :app_category_associations, dependent: :destroy
  has_many :categories, through: :app_category_associations

  # Comentários
  has_many :comments, dependent: :destroy

  # Usuários que favoritaram o aplicativo
  has_many :user_app_associations, dependent: :destroy
  has_many :users, through: :user_app_associations

  # Screen shots
  has_many :screen_shots

  # Thumbnail
  has_attached_file :thumbnail, styles: { large: "x160>",
                                          medium: "x90",
                                          small: "x32" }

  # Rating
  has_reputation :rating, source: :user, aggregated_by: :average

  def App.filter_by_categories(filter)
    if filter
      App.joins(:categories).where(categories: {id: filter})
    else
      App
    end
  end
end
