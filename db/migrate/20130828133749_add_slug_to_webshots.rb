class AddSlugToWebshots < ActiveRecord::Migration
  def change
    add_column :webshots, :slug, :string
    add_index :webshots, :slug, unique: true
  end
end
