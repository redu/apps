# encoding: utf-8

class Category < ActiveRecord::Base
  attr_accessible :name, :kind
  has_many :app_category_associations, dependent: :destroy
  has_many :apps, through: :app_category_associations, dependent: :destroy
  validates_presence_of :name, :kind

  scope :filter, where(kind: "Nível")

  KIND_ORDER = {
    "Nível" => 1,
    "Subnível" => 2,
    "Área" => 3,
    "Subárea" => 4
  }

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

  # Recebe um aplicativo, uma string indicando o tipo de categoria desejada e
  # retorna um array de categorias que satisfazem o kind especificado
  def self.get_by_kind(app, kind)
    app.categories.select { |c| c.kind.eql? kind }
  end

  # Recebe um aplicativo e retorna uma hash com chaves kind e valores array com
  # os nomes de categoria de cada tipo
  def self.get_names_by_kind(app)
    hash = Hash.new(Array.new)
    app.categories.sort.each do |c|
      hash.store(c.kind, get_by_kind(app, c.kind).collect(&:name))
    end

    hash
  end

  # Define ordem de Category de acordo com o estabelecido em KIND_ORDER
  def <=> (category)
    KIND_ORDER[self.kind] <=> KIND_ORDER[category.kind]
  end
end
