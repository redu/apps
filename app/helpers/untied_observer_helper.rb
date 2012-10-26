module UntiedObserverHelper

  @@model_data = Psych.load(File.open("#{Rails.root}/config/model_data.yml"))
  #TOD_DO MOVE THIS LOGIC TO UNTIED_USER_HELPER
  def _create_user(data)
    strip_user_data(data)
    data.merge!(uid: data.delete(:id)) #O id original é armazenado como uid
    data.merge!(role: :member)

    User.new(data).save
  end

  def _update_user(data)
    strip_user_data(data)
    uid = data.delete(:id)
    data.merge!(uid: uid)
    user = User.find_by_uid(uid)
    data.each_pair { |key, value| user.send("#{key.to_s}=", value)}
    user.save
  end

  def strip_user_data(data) #KILL ME PLZ
    data.delete_if do |key, value|
      not [:login, :first_name, :last_name, :id].include?(key)
    end
  end

  def strip_useless_data(data, args)
    data.delete_if do |key, value|
      not args.include?(key.to_s)
    end
  end

  def create(data, model_info)
    strip_useless_data(data, model_info['attributes'])
    data.merge!(model_info['id'] => data.delete(:id)) #TRANSLATES OUR ID
    model_info.fetch('include_data', []).each { |el| data.merge!(el) } #ADD DEFAULT INFO

    model_info.fetch('check_for', []).each do |key, value|

    end

    model_info['model_name'].constantize.new(data).save
  end

  def update(data, model_info)

  end

  def method_missing(name, *args, &block)
    #checa por "metodo"_"modelo", ex: create_user, update_environment, etc.
    match = /(?<method>[a-z]+?)_(?<model>[a-z]+)/.match(name)
    if check_match(match)
      self.send(match[:method], args[0], @@model_data[match[:model]])
    else
      super
    end
  end

  def check_match(match)
    match  and ['create', 'update'].include?(match[:method]) and
    @@model_data.keys.include?(match[:model])
  end
end