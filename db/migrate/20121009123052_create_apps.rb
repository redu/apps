class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name
      t.string :author
      t.string :language
      t.text :objective
      t.text :synopsis
      t.text :description
      t.text :classification
      t.string :country
      t.text :publishers
      t.text :submitters
      t.string :url
      t.string :copyright
      t.attachment :thumbnail

      t.timestamps
    end
  end
end
