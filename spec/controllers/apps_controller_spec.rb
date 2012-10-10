require 'spec_helper'

describe AppsController do
   context "When filtering app by category" do
      before(:each) do
         @categories = (0..3).collect {|i| Category.create(:name => "Cat #{i}")}
         @apps = 10.times.collect do |i|
            # app = App.create(:name => "App #{i}")
            app = FactoryGirl.create(:app)
            rand(3).times {|i| app.categories << @categories.sample}
            app
         end
      end

      it "should return correct number of apps" do
         get :index , :filter => [@categories.first.name]
         correct_number = @apps.select {|a| a.categories.include?(@categories.first) }.length
         assigns(:apps).length.should == correct_number
      end

      it "should return corret type of apps" do
         get :index, :filter => [@categories.first.name]
         assigns(:apps).all? {|a| a.categories.include?(@categories.first)}.should == true
      end
   end
end
