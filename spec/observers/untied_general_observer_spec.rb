require 'spec_helper'

describe UntiedGeneralObserver do
  let(:subject) { ::UntiedGeneralObserver.instance }
    context '#notfiy' do
      %w(user environment course space subject user_course_association).each do |name|
        it "should call create_proxy with payload" do
          subject.should_receive("create_proxy".to_sym)
          subject.notify(:after_create, "#{name}".to_sym, :core,
            {"#{name}" => {} })
        end

        it "should call update_proxy with payload" do
          subject.should_receive("update_proxy")
          subject.notify(:after_update, "#{name}".to_sym, :core,
            {"#{name}" => {}})
        end

        it "should call destroy_proxy with payload" do
          subject.should_receive("destroy_proxy")
          subject.notify(:after_destroy, "#{name}".to_sym, :core,
            {"#{name}" => {}})
        end
      end
    end
end