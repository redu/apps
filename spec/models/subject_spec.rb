# encoding: utf-8
require 'spec_helper'

describe Subject do
  # ID do Subject no Redu
  it { should respond_to(:core_id) }
  it { should_not validate_presence_of(:core_id) }
  it { should_not validate_uniqueness_of(:core_id) }

  # Nome do Subject
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Disciplina à qual o Subject pertence
  it { should belong_to(:space) }
  it { should validate_presence_of(:space) }

  #Lectures do subject
  it { should have_many(:lectures)}

  context "class method" do
    let(:params) { { token: 123, space_sid: 1, subject: "Meu Módulo" } }

    describe :create_via_api do

      context "with valid params" do
        before do
          stub_request(:post, "http://www.redu.com.br/api/spaces/1/subjects").
            to_return(status: 201, body: { name: params[:subject],
                                           id: 1 }.to_json)
          @ret = Subject.create_via_api(params)
        end

        it "should return subject instance" do
          @ret.class.should == Subject
        end
      end
    end

    describe :parse_subject do
      it "should format params properly" do
        Subject.parse_subject(params).should ==
          { subject: { name: params[:subject] } }.to_json
      end
    end

    describe :post_to_api_url do
      it "should format url properly" do
        Subject.post_to_api_url(params[:space_sid]).should ==
           "/api/spaces/#{params[:space_sid]}/subjects"
      end
    end
  end
end
