class ChangeCertificateToCertificates < ActiveRecord::Migration
  def up
   Qualificationaward.where(:name => 'Certificate').each do |qa|
      qa.update_attributes!(:name => 'Certificates')
   end
  end

  def down
  end
end
