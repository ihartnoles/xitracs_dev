class NewhiresController < ApplicationController
    
  def index  	
    	@newhire = Newhire.new    
  end

  def show   
      @newhires = Newhire.all
      @newhire_count = Newhire.all.count     
  end

  def edit
      @newhire = Newhire.find(params[:id])
      @newhirecourses = Newhirecourse.where(:newhire_id => params[:id])
      @newhiredocuments = Newhiredocument.where(:newhire_id => params[:id])
      #todo newhirecredentials
  end

  def displaydetails
      @newhire = Newhire.find(params[:id])
      

      @newhirecourses = Newhirecourse.where(:newhire_id => params[:id])
      @newhiredocuments = Newhiredocument.where(:newhire_id => params[:id])

      @newhire_dept = Department.find(@newhire.department_id)
      
      @newhirecredentials = Newhirecredential.where(:newhire_id => params[:id])

      @newhire_credits_added  = Newhirecredit.where(:newhire_id => params[:id])
      
      @newhire_comments_added = Newhirecomment.where(:newhire_id => params[:id])
  end


  def create
       if ( params[:first_name].blank? || params[:last_name].blank? ) 
          flash[:notice] = 'Please provide both a firstname and a lastname'
          redirect_to newhires_path
        else
  	      @newhire = Newhire.new(:first_name => params[:first_name], :middle_name => params[:middle_name],:last_name =>params[:last_name], :school_id => session[:school_id], :department_id => session[:department_id])
		  
          if params[:middle_name].blank? 
          	 @newhire.middle_name = nil
          else 
          	 @newhire.middle_name = params[:middle_name]
          end

      	  if @newhire.save
      	    session[:newhire_id] = @newhire.id
            session[:newhire_info] = @newhire
      	    #redirect_to next_wizard_path
             flash[:notice] = "Instructor successfully created."
      	    redirect_to newhirecourses_path 
      	  else
      	    redirect_to newhirecourses_path
      	  end	 
       end
  end

end