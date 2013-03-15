class RenameDocTypeColumn < ActiveRecord::Migration
  def up
  	 rename_column :newhiredocuments, :doc_type, :verified
  end

  def down
  end
end
