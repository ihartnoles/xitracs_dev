class RenameException < ActiveRecord::Migration
  def up
    Qualificationreason.where(:name => 'Request for Exception').each do |qr|
      qr.update_attributes!(:name => 'Request for Exception or Terminal Justification')
    end
  end

  def down
  end
end
