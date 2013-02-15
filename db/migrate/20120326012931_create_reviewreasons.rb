class CreateReviewreasons < ActiveRecord::Migration
  def change
    create_table :reviewreasons do |t|
      t.string    :name
      t.boolean   :review_passed

      t.timestamps
    end
  end
end
