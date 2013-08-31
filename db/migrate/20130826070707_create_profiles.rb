class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.belongs_to :user, index: true
      t.string :nickname
      t.attachment :photo

      t.integer :webshots_count, :default => 0
      t.integer :shares_count, :default => 0


      t.timestamps
    end
  end
end
