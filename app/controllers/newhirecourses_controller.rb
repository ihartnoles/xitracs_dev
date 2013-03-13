class NewhirecoursesController < ApplicationController

  layout "precredentialing"
  
  def index
    @newhire = Newhire.find(session[:newhire_id])

  	@newhirecourse = Newhirecourse.new
  	@newhire_courses_added = Newhirecourse.where(:newhire_id => params[:newhire_id])
    #@newhire_courses_added = Newhirecourse.where(:newhire_id => session[:newhire_id])
    @newhire_dept = Department.find(@newhire.department_id)
  end

  def edit
   @newhire = Newhire.find(params[:newhire_id])
	 @newhirecourse = Newhirecourse.find(params[:id])
  end

  def update
		@newhirecourse = Newhirecourse.find(params[:id])

	  	if @newhirecourse.update_attributes(params[:newhirecourse])
         flash[:notice] = "Course successfully updated."
      	else
         flash[:notice] = "There was a problem updating the course."
      	end

      	 redirect_to newhiredetails_path(params[:newhire_id])
       
  end

  def new
    if (params.has_key?(:newhire_id))
        session[:newhire_id] = params[:newhire_id]
    end
    @newhire = Newhire.find(params[:newhire_id])
  	@newhirecourse = Newhirecourse.new
    @newhire_dept = Department.find(@newhire.department_id)
  end


  def destroy
    @newhirecourse = Newhirecourse.find(params[:id])
    @newhirecourse.destroy

    #respond_to do |format|
    #  format.html { redirect_to newhirecredentials_url }
    #  format.json { head :ok }
    #end

    redirect_to newhiredetails_path(params[:newhire_id])
  end


  def create 	 
  	if (params[:commit] == 'Add' || params[:commit] == 'Save') 


    		if ( params[:course_name].blank? || params[:course_title].blank? || params[:course_description].blank?) 
              flash[:notice] = 'Please fill out all course fields'
              
      	      if (params.has_key?(:source))
      			  	redirect_to new_newhirecourse_path(params[:newhire_id])
      			  else
      			  	redirect_to newhirecourses_path
      			  end

        else 	

            	@newhire_course  = Newhirecourse.where(:newhire_id => session[:newhire_id]).count   
            	@newhirecourse = Newhirecourse.new(:name => params[:course_name], :title => params[:course_title], :description => params[:course_description], :newhire_id => session[:newhire_id])
    		
    		  	   if @newhirecourse.save
      			    #session[:newhire_id] = @newhire.id
      			    #redirect_to next_wizard_path
      			    @newhireinfo = Newhire.where(:newhire_id => session[:newhire_id])
      			    flash[:notice] = "Course to teach successfully created."
    			     else
    			   	   flash[:notice] = "There was a problem saving the course to teach."		    
    			     end

               #redirects
        			 if (params.has_key?(:source))
        			  	redirect_to newhiredetails_path(params[:newhire_id])
        			 else
        			  	#this was changed to bypass documents                  
                  redirect_to newhirecourses_path                  
        			 end
    		end

  	else
  		#redirect_to newhirecredentials_path(:newhire_id => params[:newhire_id])
      redirect_to newhiredetails_path(params[:newhire_id])
  	end		
  end 

end
