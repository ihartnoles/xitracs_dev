class CreateSectioncredentials < ActiveRecord::Migration
  def change
    create_table :sectioncredentials do |t|
      t.integer :faculty_id
      t.string :email
      t.string :qualificationaward_id
      t.string :qualification_name
      t.string :qualification_institution
      t.string :qualification_year
      t.integer :section_id

      t.timestamps
    end
  end
end
