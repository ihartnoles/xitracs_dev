class AddReviewFields < ActiveRecord::Migration
  def up
    add_column      :reasons, :review_state,    :integer,   :default => Reason.review_pending
    add_column      :reasons, :reviewer_id,     :integer
    add_column      :reasons, :reviewreason_id, :integer
    add_column      :reasons, :review_comments, :text,      :limit => nil
  end

  def down
    remove_column   :reasons, :review_state
    remove_column   :reasons, :reviewer_id
    remove_column   :reasons, :reviewreason_id
    remove_column   :reasons, :review_comments
  end
end
