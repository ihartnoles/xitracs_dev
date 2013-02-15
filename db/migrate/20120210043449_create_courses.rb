class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :title
      t.string :description
      t.integer :department_id
      t.string :level_description
      t.integer :credit
      t.string :rules
      t.string :cip_codes

      t.timestamps
    end
  end
end
