class NewhirecreditsController < ApplicationController
	def index
      @newhirecredits = Newhirecredit.new
      @newhireinstitutions = Newhireinstitution.all
      @newhire_credits_added  = Newhirecredit.where(:newhire_id => session[:newhire_id])
    end

    def edit
      @newhirecredits = Newhirecredit.find(params[:id])
      @newhireinstitutions = Newhireinstitution.all
    end

    def update

    end 

    def create

    	if (params[:commit] == 'Add') 
	    	#@newhirecredit = Newhirecredit.new(params[:newhirecredits])
	    		if ( params[:newhirecredit][:course_name].blank? ||
	    			 params[:newhirecredit][:course_description].blank? ||
	    			 params[:newhirecredit][:course_year].blank? ||
	    			 params[:newhirecredit][:newhireinstitution_id].blank? ||
	    			 params[:newhirecredit][:course_credits].blank?
	    			)
	    			 flash[:notice] = 'Please fill out all fields'
	    			 redirect_to newhirecredits_path
	    		else
	    	 	  @newhirecredit   = Newhirecredit.new(params[:newhirecredit])
			 	  @newhirecredit.newhire_id =  session[:newhire_id]
			 	  #@newhirecredit.department_id = session[:department_id]

			  	  if @newhirecredit.save
				    
				    #@newhirecredits_added = Newhirecredit.where(:newhire_id => session[:newhire_id])
				    flash[:notice] = "Relevant course added."
				  else
				   	flash[:notice] = "There was a problem saving the relevant coursework."		    
				  end
				  redirect_to newhirecredits_path
				end

	    else
	    	redirect_to newhirecomment_index_path
		end
    end
end
