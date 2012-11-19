class AddZombieToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :zombie, :boolean
  end
end
