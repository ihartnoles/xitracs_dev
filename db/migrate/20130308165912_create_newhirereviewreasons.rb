class CreateNewhirereviewreasons < ActiveRecord::Migration
  def change
     	create_table :newhirereviewreasons do |t|
	      t.integer :newhire_id
	      t.integer :course_id
	      t.integer :review_state
	      t.integer :reviewer_id
	      t.text    :review_comments

	      t.timestamps
    end
  end
end
