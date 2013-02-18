class AddNewhireIdAndNewhiredoctypeIdToNewhiredocument < ActiveRecord::Migration
  def change
    add_column :newhiredocuments, :newhire_id, :integer
    add_column :newhiredocuments, :newhiredoctype_id, :integer
  end
end
