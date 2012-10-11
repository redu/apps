class CreateAppCategoryAssociations < ActiveRecord::Migration
  def change
    create_table :app_category_associations do |t|
      t.references :app, :category
      t.timestamps
    end
    add_index :app_category_associations, [:app_id, :category_id]
  end
end
