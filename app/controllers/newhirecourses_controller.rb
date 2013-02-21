class NewhirecoursesController < ApplicationController


  def index
  	@newhirecourse = Newhirecourse.new
  	@newhire_courses_added = Newhirecourse.where(:newhire_id => session[:newhire_id])
  end

  def create
 	 
	if (params[:commit] == 'Add') 


		if ( params[:course_name].blank? || params[:course_title].blank? || params[:course_description].blank?) 
          flash[:notice] = 'Please fill out all course fields'
          redirect_to newhirecourses_path
        else 	
        	@newhire_course  = Newhirecourse.where(:newhire_id => session[:newhire_id]).count   
        	
		    @newhirecourse = Newhirecourse.new(:name => params[:course_name], :title => params[:course_title], :description => params[:course_description], :newhire_id => session[:newhire_id])
		
		  	  if @newhirecourse.save
			    #session[:newhire_id] = @newhire.id
			    #redirect_to next_wizard_path
			    flash[:notice] = "Course to teach successfully created."
			   else
			   	flash[:notice] = "There was a problem saving the course to teach."		    
			  end
			  redirect_to newhirecourses_path
		end

	else
		redirect_to newhiredocuments_path
	end
  end 
end
