class AddQualificationReasons < ActiveRecord::Migration
  def up
  	Qualificationreason.create(:name => 'Terminal Degree In Teaching Discipline')
  	Qualificationreason.create(:name => 'Other Terminal degree - Credential by Research/Experience/Creative Activity')
    Qualificationreason.create(:name => 'Other Terminal degree - Credential by Coursework')
    Qualificationreason.create(:name => 'Other Terminal degree - Credential by Coursework and Research/Experience/Creative Activity')
  	Qualificationreason.create(:name => 'Masters Degree')
  	Qualificationreason.create(:name => 'Bachelors Degree')
    Qualificationreason.create(:name => 'Request for Exception')
  end

  def down
    Qualificationreason.destroy_all
  end
end
