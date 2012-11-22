class ModelHelper
  @@instances = {}

  def initialize(model_data)
    @model = model_data['name'].constantize
    @model_data = model_data
  end

  def find(id)
    @model.send("find_by_#{@model_data[:mappings][:id]}", id)
  end

  def create_zombie(id)
    zombie = @model.new(@model_data[:mappings][:id] => id)
    zombie.save(validate: false)
    zombie
  end

  def create_model(payload)
    temp_model = (find(payload[@model_data[:mappings][:id]]) or @model.new)
    payload.each_pair {|key, value| temp_model.send("#{key.to_s}=", value)} if temp_model.zombie #sets the attributes
    temp_model.save
  end

  def update_model(payload)
    temp_model = (find(payload[@model_data[:mappings][:id]]) or @model.new)
    payload.each_pair {|key, value| temp_model.send("#{key.to_s}=", value)}
    temp_model.save
  end

  def destroy_model(payload)
    temp_model = find(payload[@model_data[:mappings][:id]])
    temp_model.destroy if temp_model
  end

  def self.new(*args, &block)
    old_instance = @@instances[args[0]['name']]
    return old_instance if old_instance

    obj = ModelHelper.allocate
    obj.send(:initialize, *args, &block)
    @@instances[args[0]['name']] = obj
    obj
  end
end
