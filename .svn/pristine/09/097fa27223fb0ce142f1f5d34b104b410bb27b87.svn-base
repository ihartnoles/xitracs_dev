class AddReasonsReviewreasonsJoinTable < ActiveRecord::Migration
  def self.up
    create_table :reasons_reviewreasons, :id => false do |t|
      t.integer :reason_id
      t.integer :reviewreason_id
    end
  end

  def self.down
    drop_table :reasons_reviewreasons
  end
end
