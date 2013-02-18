class CreateNewhirecourses < ActiveRecord::Migration
  def change
    create_table :newhirecourses do |t|
      t.string :name
      t.string :title
      t.string :description
      t.integer :department_id
      t.timestamps
    end
  end
end
