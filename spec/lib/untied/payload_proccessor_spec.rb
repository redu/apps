require 'spec_helper'

describe Untied::PayloadProccessor do
  let(:config) do
    ReduApps::Application.config.untied['model_data']['User']
  end

  before(:all) do
    @proccessor = Untied::PayloadProccessor.new(config)
  end

  describe 'proccess' do
    let(:payload) {{"id"=> 22, 'login' => 'sexy_jedi_3000',
      'first_name' => 'Luke', 'last_name' => 'skywalker', thingy: 'aaaa',
      'useless_thing' => 2}}

    it 'should translate mappings' do
      new_load = @proccessor.proccess(payload)
      new_load.fetch("core_id", nil).should == payload["id"]
    end

    it 'should remove useless data' do
      new_load = @proccessor.proccess(payload)
      new_load.fetch("useless_thing", nil).should be_nil
    end

    it "should not raise error if there is no mappings" do
      new_config = config.clone
      new_config.delete(:mappings)
      @processor = Untied::PayloadProccessor.new(new_config)
      expect {
        @processor.proccess(payload)
      }.to_not raise_error
    end
  end
end
