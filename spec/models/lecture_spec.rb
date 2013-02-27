require 'spec_helper'

describe Lecture do
  # ID do Lecture no Redu
  it { should respond_to(:core_id) }
  it { should_not validate_presence_of(:core_id) }
  it { should_not validate_uniqueness_of(:core_id) }

  # Nome do Lecture
  it { should respond_to(:name) }
  it { should validate_presence_of(:name) }

  # Modulo ao qual o Lecture pertence
  it { should belong_to(:subject) }

  # Aplicativo ao qual a aula está vinculada
  it { should belong_to(:app) }

  context "class method" do
    let(:params) { { token: 123, subject_suid: 1, lecture_name: "Minha Aula", url: "http://foo.bar" } }

    describe :create_via_api do

      context "with valid params" do
        before do
          stub_request(:post, "http://www.redu.com.br/api/subjects/1/lectures").
            to_return(status: 201, body: "")
          Lecture.create_via_api(params)
        end

        it "should do something I don't know what it is"
      end
    end

    describe :parse_lecture do
      it "should format params properly" do
        Lecture.parse_lecture(params).should ==
          { lecture: { name: params[:lecture_name], type: "Canvas",
                       current_url: params[:url] }
          }.to_json
      end
    end

    describe :post_to_api_url do
      it "should format url properly" do
        Lecture.post_to_api_url(params[:subject_suid]).should ==
          "/api/subjects/#{params[:subject_suid]}/lectures"
      end
    end
  end
end
