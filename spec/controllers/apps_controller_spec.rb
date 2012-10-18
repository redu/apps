require 'spec_helper'

describe AppsController do
   describe "GET index" do
      context "When filtering app by category" do
         before(:each) do
            @categories = (0..3).collect {|i| Category.create(:name => "Cat #{i}")}
            @apps = 10.times.collect do |i|
               # app = App.create(:name => "App #{i}")
               app = FactoryGirl.create(:app)
               app.categories << @categories.sample(rand(4))
               app
            end
         end

         it "should return correct number of apps" do
            get :index , :filter => [@categories.first.name], :locale => 'pt-BR'
            correct_number = @apps.select {|a| a.categories.include?(@categories.first) }.length
            assigns(:apps).length.should == correct_number
         end

         it "should return corret type of apps" do
            get :index, :filter => [@categories.first.name], :locale => 'pt-BR'
            assigns(:apps).all? {|a| a.categories.include?(@categories.first)}.should == true
         end
      end
   end

   describe "GET show" do
      before do
         @app = FactoryGirl.create(:app)
      end

      context "with valid params" do
         before do
            @params = { :id => @app.id, :locale => 'pt-BR' }
         end

         it "should increment app views counter" do
            before = @app.views
            get :show, @params
            App.find(@app.id).views.should == before + 1
         end
      end
   end
end
