# encoding: utf-8

class Category < ActiveRecord::Base
  attr_accessible :name, :kind
  has_many :app_category_associations, dependent: :destroy
  has_many :apps, through: :app_category_associations, dependent: :destroy
  validates_presence_of :name, :kind

  scope :filter, where(kind: "Nível")

  # Recebe array de Apps e retorna categorias (filtros) associadas às Apps
  def self.filters_on(apps)
    apps.collect(&:categories).flatten.select { |c| c.kind == "Nível" }
  end

  # Recebe array de Category e retorna hash com quantidades associadas aos nomes
  # de categorias no formato { nome: quantidade_de_vezes_que_aparece_no_array }
  def self.count_filters_on(categories)
    hash = Hash.new(0)
    categories.collect(&:name).each { |v| hash.store(v, hash[v]+1) }

    hash
  end

  def self.get_by_kind(app, kind)
    app.categories.select { |c| c.kind.eql? kind }
  end
end
