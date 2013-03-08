class CreateNewhiresignoffs < ActiveRecord::Migration
  def change
    create_table :newhiresignoffs do |t|
      t.integer :newhire_id
      t.integer :course_id
      t.integer :signed_off
      t.integer :user_id
      t.text    :comment
      
      t.timestamps
    end
  end
end
