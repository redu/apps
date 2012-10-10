namespace :bootstrap do
   desc "Insert apps with random categories"
   task :default_data => :environment do
      categories = (0..5).collect {|i| Category.create(:name =>  "Cat #{i}")}
      100.times do |i|
         app = App.create(:name => "App-#{i}")
         app.categories << categories.sample(rand(4))
      end
   end

   desc "Run all"
   task :all  => [:default_data]

end