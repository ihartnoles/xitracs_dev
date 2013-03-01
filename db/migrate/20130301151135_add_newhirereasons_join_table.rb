class AddNewhirereasonsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :newhirereasons_newhirereviewreasons, :id => false do |t|
      t.integer :newhirereason_id
      t.integer :newhirereviewreason_id
    end
  end

  def self.down
    drop_table :newhirereasons_newhirereviewreasons
  end
end
