class PayloadProccessor
  # Traduz payload recebido via Untied de acordo com os atributos e mapeamentos
  # de config/model_data.yml.
  @@instances = {}

  def initialize(model_data)
    @model_data = model_data
  end

  def proccess(payload)
    new_payload = slice_useless_attrs(payload)
    map_attrs(new_payload)
  end

  def dependencies
    @model_data.fetch('check_for', [])
  end

  def self.new(*args, &block)
    old_instance = @@instances[args[0]['name']]
    return old_instance if old_instance

    obj = PayloadProccessor.allocate
    obj.send(:initialize, *args, &block)
    @@instances[args[0]['name']] = obj
    obj
  end

  protected

  # Faz mapeamento de atributos
  def map_attrs(payload)
    mappings = @model_data.fetch('mappings', {})

    mappings.each do |k, v|
      payload.merge!(v => payload.delete(k))
    end

    payload
  end

  # Remove atributos irrelevantes
  def slice_useless_attrs(payload)
    payload.reject do |key, value|
      !@model_data['attributes'].include?(key)
    end
  end
end
