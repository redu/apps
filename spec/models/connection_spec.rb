# encoding: utf-8
require 'spec_helper'

describe Connection do

  let(:connection) { Connection.new("tokenhere") }

  context "when performing requests" do
    before do
      stub_request(:get, "http://www.redu.com.br/api/spaces/1/subjects").
        to_return(status: 200, body: { funcionou: true }.to_json)
      stub_request(:post, "http://www.redu.com.br/api/spaces/1/subjects").
        to_return(status: 201, body: { funcionou: true }.to_json)
    end

    it "should perform GET request" do
      connection.get("/api/spaces/1/subjects")
    end

    it "should perform POST request" do
      connection.post("/api/spaces/1/subjects", { name: "Meu Módulo"} ) { }
    end
  end # context "when performing requests"
end
