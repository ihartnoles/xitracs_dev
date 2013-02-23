class CreateNewhirecredentials < ActiveRecord::Migration
  def change
    create_table :newhirecredentials do |t|
      t.integer :newhire_id
      t.integer :qualificationreason_id

      t.timestamps
    end
  end
end
