class CreateKeyvalues < ActiveRecord::Migration
  def change
    create_table :keyvalues do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
