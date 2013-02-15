class CreateTenurestatuses < ActiveRecord::Migration
  def change
    create_table :tenurestatuses do |t|
      t.string :name

      t.timestamps
    end
  end
end
