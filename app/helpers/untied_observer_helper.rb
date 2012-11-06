module UntiedObserverHelper
  @@model_data =
    HashWithIndifferentAccess.new_from_hash_copying_default(
      Psych.load(File.open("#{Rails.root}/config/model_data.yml")))

  def create(data, model_info)
    strip_useless_data(data, model_info['attributes'])
    id = data.delete(:id)
    data.merge!(model_info['id'] => id) #TRANSLATES OUR ID
    model_info.fetch('include_data', []).each { |el| data.merge!(el) } #ADD DEFAULT INFO
    create_dependencies(data, model_info) # Checa e cria os relacionamentos
    model = (find_model(model_info['name'], id) or model_info['name'].constantize.new)
    set_attributes(model, data) if model.zombie #Faço isso porque eu quero que a validacao falhe se objeto nao for um zumbi
    model.save
  end

  def update(data, model_info)
    strip_useless_data(data, model_info['attributes'])
    model = (find_model(model_info['name'], data[:id]) or model_info['name'].constantize.new)
    create_dependencies(data, model_info) #TODO: CHECAR SE OS RELACIONAMENTOS MUDARAM ANTES DE CONSULTAR
    data.merge!(model_info['id'] => data.delete(:id)) # TRADUZ O ID
    set_attributes(model, data) #atualiza os campos
    model.save
  end

  def method_missing(name, *args, &block)
    #checa por "metodo"_"modelo", ex: create_user, update_environment, etc.
    match = /(?<method>[a-z]+?)_(?<model>[a-z_]+)/.match(name)

    if check_match(match)
      data = HashWithIndifferentAccess.new_from_hash_copying_default(args[0].values[0])
      self.send(match[:method], data, @@model_data[match[:model].classify])
    else
      super
    end
  end

  def strip_useless_data(data, args)
    data.delete_if do |key, value|
      not args.include?(key.to_s)
    end
  end

  def check_match(match)
    match  and ['create', 'update'].include?(match[:method]) and
    @@model_data.keys.include?(match[:model].classify)
  end

  def create_dependencies(data, model_info)
    model_info.fetch('check_for', []).each do |key, value|
      model = (find_model(key, data[value]) or create_zombie_model(key, data[value]))
      data[value] = model.id
    end
  end

  def find_model(name, id)
    name.constantize.send("find_by_#{@@model_data[name]['id']}", id)
  end

  def create_zombie_model(name, id)
    model = name.constantize.new(@@model_data[name]['id'] => id)
    model if model.save(validate: false)
  end

  def set_attributes(model, data)
    data.each_pair { |key, value| model.send("#{key.to_s}=", value)}
  end
end