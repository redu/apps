# encoding: utf-8
shared_examples :has_remote_file do |name|
  it "should respond to #{name}_remote_url" do
    subject.should respond_to "#{name}_remote_url"
  end

  it "should respond to #{name}_remote_url=" do
    subject.should respond_to "#{name}_remote_url="
  end
end
