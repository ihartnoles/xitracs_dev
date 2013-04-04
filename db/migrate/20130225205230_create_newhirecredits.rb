class CreateNewhirecredits < ActiveRecord::Migration
  def change
    create_table :newhirecredits do |t|
      t.integer :newhire_id
      t.string :course_name
      t.string :course_description
      t.string :course_year
      t.integer :course_credits
      t.integer :semester_credits
      t.integer :newhireinstitution_id

      t.timestamps
    end
  end
end
