class CreateWebshots < ActiveRecord::Migration
  def change
    create_table :webshots do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :url
      t.text :desc
      t.attachment :photo
      t.boolean :saved, :default => false
      t.integer :shares_count, :default => 0

      t.timestamps
    end
  end
end
