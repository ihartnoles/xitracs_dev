class CreateNewhireinstitutions < ActiveRecord::Migration
  def change
    create_table :newhireinstitutions do |t|
      t.string :name

      t.timestamps
    end
  end
end
