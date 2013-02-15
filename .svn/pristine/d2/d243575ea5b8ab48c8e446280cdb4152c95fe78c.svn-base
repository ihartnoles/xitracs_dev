class Index01 < ActiveRecord::Migration
  def up
    add_index :keyvalues, :key 
    add_index :titles, :name
    add_index :ranks, :name
    add_index :employmentstatuses, :name
    add_index :tenurestatuses, :name

    add_index :schools, :name, {:unique => true}
    add_index :departments, :name, {:unique => true}
    add_index :faculties, :znumber, {:unique => true}
    add_index :courses, :name, {:unique => true}
    add_index :qualifications, :name, {:unique => true}
    add_index :qualificationawards, :name, {:unique => true}
    add_index :sections, :name, {:unique => true}
  end

  def down
    remove_index :keyvalues, :key 
    remove_index :titles, :name
    remove_index :ranks, :name
    remove_index :employmentstatuses, :name
    remove_index :tenurestatuses, :name
    
    remove_index :schools, :name
    remove_index :departments, :name
    remove_index :faculties, :znumber
    remove_index :courses, :name
    remove_index :qualifications, :name
    remove_index :qualificationawards, :name
    remove_index :sections, :name
  end
end
