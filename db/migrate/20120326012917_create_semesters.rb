class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :name
      t.string :prefix
      t.boolean :enabled, :default => true
      t.timestamps
    end

    remove_column :sections, :semester    
    add_column    :sections, :semester_id, :integer
  end
end
