require 'spec_helper'

describe PayloadProccessor do
  let(:config) do
    ReduApps::Application.config.untied['model_data']['User']
  end
  before(:all) do
    @proccessor = PayloadProccessor.new(config)
  end
  describe 'proccess' do
    let(:payload) {{"id"=> 22, 'login' => 'sexy_jedi_3000',
      'first_name' => 'Luke', 'last_name' => 'skywalker', coisado: 'aaaa',
      'coisa_inutil' => 2}}

    it 'should translate mappings' do
      new_load = @proccessor.proccess(payload)
      new_load.fetch("core_id", nil).should == payload["id"]
    end

    it 'should remove useless data' do
      new_load = @proccessor.proccess(payload)
      new_load.fetch("coisa_inutil", nil).should be_nil
    end

    it "should not raise error if there is no mappings" do
      config.delete(:mappings)
      @processor = PayloadProccessor.new(config)

      expect {
        @processor.proccess(payload)
      }.to_not raise_error
    end
  end
end
