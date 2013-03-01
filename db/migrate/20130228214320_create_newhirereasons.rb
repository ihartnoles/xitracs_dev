class CreateNewhirereasons < ActiveRecord::Migration
  def change
    create_table :newhirereasons do |t|
      t.integer :user_id
      t.integer :newhire_id
      t.integer :course_id
      t.integer :qualificationreason_id
      t.text :comments
      t.integer :reviewer_id
      t.text :review_comments
      t.integer :review_state
      t.integer :dean_id
      t.integer :dean_comments
      t.integer :dean_signoff

      t.timestamps
    end
  end
end
