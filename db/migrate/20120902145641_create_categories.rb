class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.string :path
      t.integer :parent_id

      t.timestamps
    end
  end
end
