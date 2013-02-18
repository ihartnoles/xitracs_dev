class CreateNewhiredocuments < ActiveRecord::Migration
  def change
    create_table :newhiredocuments do |t|
      t.string :doc_type
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
