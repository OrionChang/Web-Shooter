class CreateWebshots < ActiveRecord::Migration
  def change
    create_table :webshots do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.string :url
      t.text :desc
      t.attachment :photo

      t.timestamps
    end
  end
end
