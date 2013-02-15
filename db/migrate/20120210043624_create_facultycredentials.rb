class CreateFacultycredentials < ActiveRecord::Migration
  def change
    create_table :facultycredentials do |t|
      t.integer :faculty_id
      t.string :email
      t.string :qualificationaward_id
      t.string :qualification_name
      t.string :qualification_institution
      t.string :qualification_field
      t.string :qualification_year
      t.string :transcript_on_file
      t.string :cip_codes

      t.timestamps
    end
  end
end
