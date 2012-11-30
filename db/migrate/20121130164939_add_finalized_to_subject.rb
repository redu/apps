class AddFinalizedToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :finalized, :boolean
  end
end
