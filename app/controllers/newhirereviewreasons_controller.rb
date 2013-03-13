class NewhirereviewreasonsController < ApplicationController

	layout "precredentialing"
	
	def create
		
        @newhirecredential = Newhirecredential.new(:qualificationreason_id => params[:qualificationreason_id], 
                                                     :qualification_explanation => params[:qualification_explanation], 
                                                     :newhire_id => params[:newhire_id],
                                                     :course_id => params[:course_id])
        

		redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id] , :id => params[:course_id])
	end


end
