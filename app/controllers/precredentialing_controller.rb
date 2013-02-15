class PrecredentialingController < ApplicationController
  
  def credentialsform
  	@reason = Reason.new
    @reason.qualificationreason_id = Qualificationreason.find(:first).id
    @new_reason = true

    @credit = Credit.new  
    @credit.semester_credits = true;
  end

end
