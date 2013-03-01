class CreateNewhirereviewreasons < ActiveRecord::Migration
  def change
    create_table :newhirereviewreasons do |t|
      t.string :name
      t.integer :review_passed

      t.timestamps
    end
  end
end
