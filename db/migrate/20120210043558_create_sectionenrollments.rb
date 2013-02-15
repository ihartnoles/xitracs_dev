class CreateSectionenrollments < ActiveRecord::Migration
  def change
    create_table :sectionenrollments do |t|
      t.integer :section_id
      t.integer :faculty_id
      t.string :email
      t.string :section_role

      t.timestamps
    end
  end
end
