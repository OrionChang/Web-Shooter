class AddStatusToWebshots < ActiveRecord::Migration
  def change
    add_column :webshots, :saved, :boolean, :default => false

  end
end
