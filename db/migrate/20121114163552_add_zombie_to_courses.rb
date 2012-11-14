class AddZombieToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :zombie, :boolean
  end
end
