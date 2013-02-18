class NewhirecoursesController < ApplicationController


  def index
  	@newhirecourse = Newhirecourse.new
  end

  def create
 	 @newhirecourse = Newhirecourse.new(:name => params[:course_name], :title => params[:course_title], :description => params[:course_description])
	  	
  	  if @newhirecourse.save
	    #session[:newhire_id] = @newhire.id
	    #redirect_to next_wizard_path
	   else
	    redirect_to newhires_path
	  end
  end 
end
