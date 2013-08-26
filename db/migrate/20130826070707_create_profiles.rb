class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.string :nickname
      t.attachment :photo

      t.timestamps
    end
  end
end
