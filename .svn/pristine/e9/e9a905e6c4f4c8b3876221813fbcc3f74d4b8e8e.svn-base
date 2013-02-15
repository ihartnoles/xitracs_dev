class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :faculty_id
      t.integer :facultycredential_id
      t.string  :course_name
      t.string  :course_description
      t.string  :course_year
      t.integer :course_credits
      t.boolean :semester_credits

      t.timestamps
    end
  end
end
