class AddSchoolIdToNewhires < ActiveRecord::Migration
  def change
    add_column :newhires, :school_id, :integer, :after => :department_id
    remove_column :newhires, :newhiredocument_id
  end
end
