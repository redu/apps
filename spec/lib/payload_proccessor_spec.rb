require 'spec_helper'

describe PayloadProccessor do
  before(:all) do
    @proccessor = PayloadProccessor.new(ReduApps::Application.config.untied['model_data']['User'])
  end
  describe 'proccess' do
    let(:payload) {{"id"=> 22, 'login' => 'sexy_jedi_3000',
      'first_name' => 'Luke', 'last_name' => 'skywalker', coisado: 'aaaa',
      'coisa_inutil' => 2}}

    it 'should translate id' do
      new_load = @proccessor.proccess(payload)
      new_load.fetch("core_id", nil).should == payload["id"]
    end

    it 'should remove useless data' do
      new_load = @proccessor.proccess(payload)
      new_load.fetch("coisa_inutil", nil).should be_nil
    end
  end
end