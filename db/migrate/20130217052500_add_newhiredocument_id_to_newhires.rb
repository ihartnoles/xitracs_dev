class AddNewhiredocumentIdToNewhires < ActiveRecord::Migration
  def change
    add_column :newhires, :newhiredocument_id, :integer
  end
end
