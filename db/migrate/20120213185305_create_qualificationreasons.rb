class CreateQualificationreasons < ActiveRecord::Migration
  def change
    create_table :qualificationreasons do |t|
      t.string :name

      t.timestamps
    end
  end
end
