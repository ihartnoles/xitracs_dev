class CreateNewhirereviewmessages < ActiveRecord::Migration
  def change
    create_table :newhirereviewmessages do |t|
      t.integer :newhire_id
      t.integer :course_id
      t.string :from
      t.string :to
      t.text :body

      t.timestamps
    end
  end
end
