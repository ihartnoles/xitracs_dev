class PrecredentialingController < ApplicationController
  
  def credentialsform
  	@reason = Reason.find(session[:reason_id])
  	
    @reason.qualificationreason_id = Qualificationreason.find(:first).id
    @new_reason = true

    @credit = Credit.new  
    @credit.semester_credits = true;
  end

  def savecomments
  	@reason = Reason.new
  	@reason.update_attributes(params[:reason]) 
  	session[:reason_id] = @reason.id

  	redirect_to :action => 'credentialsform'
  end
end



