class AddSharesToWebshots < ActiveRecord::Migration
  def change
    add_column :webshots, :shares, :integer, :default => 0
  end
end
