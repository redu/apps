require 'spec_helper'

describe UntiedGeneralObserver do
  let(:subject) { ::UntiedGeneralObserver.instance }
    context '#notfiy' do
      %w(user environment course space subject user_course_association).each do |name|
        it "should call create_#{name} with payload" do
          subject.should_receive("create_#{name}".to_sym).with(an_instance_of(Hash))
          subject.notify(:after_create, "#{name}".to_sym, :core,
            {"#{name}" => {} })
        end

        it "should call update_#{name} with payload" do
          subject.should_receive("update_#{name}").with(an_instance_of(Hash))
          subject.notify(:after_update, "#{name}".to_sym, :core,
            {"#{name}" => {}})
        end

        it "should call destroy_#{name} with payload" do
          subject.should_receive("destroy_#{name}").with(an_instance_of(Hash))
          subject.notify(:after_destroy, "#{name}".to_sym, :core,
            {"#{name}" => {}})
        end
      end
    end
end