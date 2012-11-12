class UntiedObserverHelper < Untied::Consumer::Observer

  def call_method(method, kind, payload)
    model_data = config.fetch(kind.classify) {|k| raise "Invalid Kind #{k}"}
    model_helper = ModelHelper.new(model_data)
    payload_proccessor = PayloadProccessor.new(model_data)
    new_payload = payload_proccessor.proccess(payload)
    self.send(method, new_payload, model_helper, payload_proccessor)
  end

  def create_proxy(kind, payload)
    call_method("create", kind, payload)
  end

  def create(payload, model_helper, payload_proccessor)
    new_payload = create_dep(payload, payload_proccessor)
    model_helper.create_model(new_payload)
  end

  def update(payload, model_helper, payload_proccessor)
    new_payload = create_dep(payload, payload_proccessor)
    model_helper.update_model(new_payload)
  end

  def create_dep(payload, payload_proccessor)
    new_payload = payload.clone
    payload_proccessor.dependencies.each do |key, value|
      id = payload[value]
      aux_helper = ModelHelper.new(config[key.classify])
      modelo = (aux_helper.find(id) or aux_helper.create_zombie(id))
      new_payload.merge!(value => modelo.id)
    end
    new_payload
  end

  def update_proxy(kind, payload)
    call_method("update", kind, payload)
  end

  def destroy_proxy(kind, payload)
    call_method("destroy", kind, payload)
  end

  def destroy(payload, model_helper, payload_proccessor)
    model_helper.destroy_model(payload)
  end

  def config
    ReduApps::Application.config.untied['model_data']
  end
end