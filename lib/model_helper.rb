class ModelHelper
  @@instances = {}

  def initialize(model_data)
    @model = model_data['name'].constantize
    @model_data = model_data
  end

  def find(id)
    @model.send("find_by_#{@model_data['id']}", id)
  end

  def create_zombie(id)
    zombie = @model.new(@model_data['id'] => id)
    zombie.save(validate: false)
    zombie
  end

  def create_model(payload)
    modelo = (find(payload[@model_data[:id]]) or @model.new)
    payload.each_pair {|key, value| modelo.send("#{key.to_s}=", value)} if modelo.zombie #sets the attributes
    modelo.save
  end

  def update_model(payload)
    modelo = (find(payload[@model_data[:id]]) or @model.new)
    payload.each_pair {|key, value| modelo.send("#{key.to_s}=", value)}
    modelo.save
  end

  def destroy_model(payload)
    modelo = find(payload[@model_data[:id]])
    modelo.destroy if modelo
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