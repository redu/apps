require 'spec_helper'

module Paperclip
  describe RemoteAttachment do
    let(:subject) { User.new }

    context "#thumbnail_remote_url" do
      it "should define #thumbnail_remote_url=" do
        subject.should respond_to :thumbnail_remote_url=
      end

      it "should define #thumbnail_remote_url" do
        subject.should respond_to :thumbnail_remote_url
      end
    end

    context "#fill_remote_url" do
      context "when the url is accessible" do
        let(:url) { "http://foo.bar/foo.png" }
        before do
          stub_request(:get, url).to_return(status: 200, body: "",
                                            headers: {})
        end

        it "should parse the URL" do
          URI.should_receive(:parse)
          subject.thumbnail_remote_url = url
        end

        it "should assing the parsed URL to self.thumbnail" do
          subject.thumbnail_remote_url = url
          subject.thumbnail.should_not be_nil
        end

        it "should defefine readable attribute" do
          subject.thumbnail_remote_url = url
          subject.thumbnail_remote_url.should == url
        end

        it "should not fail if url is nil" do
          expect {
            subject.thumbnail_remote_url = nil
          }.to_not raise_error(URI::InvalidURIError)
        end
      end

      context "when the URL is not valid" do
        let(:url) { "xxx" }

        it "should not raise TypeError" do
          expect {
            subject.thumbnail_remote_url = url
          }.to_not raise_error(TypeError)
        end

        it "should assing nil" do
          expect {
            subject.thumbnail_remote_url = url
          }.to_not change(subject.thumbnail, :url)
        end

        it "should not assing @thumbnail_remote_url" do
          subject.thumbnail_remote_url = url
          subject.thumbnail_remote_url.should be_nil
        end
      end

      context "when the url is not accessible" do
        let(:url) { "http://foo.bar/foo.png" }
        before do
          stub_request(:get, url).to_return(status: 403, body: "",
                                            headers: {})
        end

        it "should the thumbnail be nil" do
          subject.thumbnail_remote_url = url
          subject.thumbnail be_nil
        end

        it "should create a user" do
          expect {
            subject.thumbnail_remote_url = url
          }.to_not raise_error(OpenURI::HTTPError)
        end

        it "should not assing @thumbnail_remote_url" do
          subject.thumbnail_remote_url = url
          subject.thumbnail_remote_url.should be_nil
        end
      end
    end
  end
end
