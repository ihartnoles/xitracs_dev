class NewhirecoursesController < ApplicationController


  def index
  	@newhirecourse = Newhirecourse.new
  end

  def create
 	 
	if (params[:commit] == 'Add')  	

	    @newhirecourse = Newhirecourse.new(:name => params[:course_name], :title => params[:course_title], :description => params[:course_description], :newhire_id => session[:newhire_id])
	
	  	  if @newhirecourse.save
		    #session[:newhire_id] = @newhire.id
		    #redirect_to next_wizard_path
		    flash[:notice] = "Course to teach successfully created."
		   else
		   	flash[:notice] = "There was a problem saving the course to teach."		    
		  end
		  redirect_to newhirecourses_path

	else
		redirect_to newhiredocuments_path
	end
  end 
end
