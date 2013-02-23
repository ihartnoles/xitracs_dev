class AddQualificationExplanationToNewhirecredentials < ActiveRecord::Migration
  def change
    add_column :newhirecredentials, :qualification_explanation, :text
  end
end
