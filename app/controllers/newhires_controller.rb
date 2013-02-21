class NewhiresController < ApplicationController
    
  def index  	
    	@newhire = Newhire.new    
  end

  def show   
      @newhires = Newhire.all
      @newhire_count = Newhire.all.count     
  end



  def create
       if ( params[:first_name].blank? || params[:last_name].blank? ) 
          flash[:notice] = 'Please provide both a firstname and a lastname'
          redirect_to newhires_path
        else
  	      @newhire = Newhire.new(:first_name => params[:first_name], :last_name =>params[:last_name])
		  
          if params[:middle_name].blank? 
          	 @newhire.middle_name = nil
          else 
          	 @newhire.middle_name = params[:middle_name]
          end

      	  if @newhire.save
      	    session[:newhire_id] = @newhire.id
      	    #redirect_to next_wizard_path
             flash[:notice] = "Instructor successfully created."
      	    redirect_to newhirecourses_path 
      	  else
      	    redirect_to newhirecourses_path
      	  end	 
       end
  end

end