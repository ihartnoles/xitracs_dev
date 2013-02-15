class AddReviewReasons < ActiveRecord::Migration
 def up
    Reviewreason.create(:name => 'Missing Syllabus')
    Reviewreason.create(:name => 'Missing C.V.')
    Reviewreason.create(:name => 'Missing Transcripts')
    Reviewreason.create(:name => 'Ineligible Course')
    Reviewreason.create(:name => 'Need Information On Coursework')
    Reviewreason.create(:name => 'Need Information On Research')
    Reviewreason.create(:name => 'Need Information On Other Professional Accomplishments')
    Reviewreason.create(:name => 'Other')
    Reviewreason.create(:name => 'Out of Compliance')
  end

  def down
    Reviewreason.destroy_all
  end
end


