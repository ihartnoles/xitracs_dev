class AddDeanSignoff < ActiveRecord::Migration
  def up
    add_column      :reasons, :dean_id,           :integer
    add_column      :reasons, :dean_signoff,      :boolean,   :default => false
    add_column      :reasons, :dean_signoff_date, :datetime
    add_column      :reasons, :dean_comments,     :text,      :limit => nil
  end

  def down
    remove_column   :reasons, :dean_id
    remove_column   :reasons, :dean_signoff
    remove_column   :reasons, :dean_comments
  end
end
