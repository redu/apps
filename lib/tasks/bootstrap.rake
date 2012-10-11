namespace :bootstrap do
   desc "Create apps with random categories"
   task :create_apps => :environment do
      categories = (0..5).collect {|i| Category.create(:name =>  "Cat #{i}")}
<<<<<<< Updated upstream
      100.times do |i|
         app = App.create(:name => "App-#{i}")
         rand(3).times { app.categories << categories.sample }
=======
      100.times do
         app = FactoryGirl.create(:app)
         app.categories << categories.sample(rand(4))
>>>>>>> Stashed changes
      end
   end

   desc "Create users"
   task :create_users => :environment do
      10.times do
         FactoryGirl.create(:user)
      end
   end

   desc "Run all"
   task :all  => [:create_apps, :create_users]

end