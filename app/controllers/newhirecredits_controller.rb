class NewhirecreditsController < ApplicationController
	def index
      @newhirecredits = Newhirecredit.new
      @newhireinstitutions = Newhireinstitution.all
      @newhire_credits_added  = Newhirecredit.where(:newhire_id => session[:newhire_id])
    end

    def edit
      @newhire = Newhire.find(params[:newhire_id])
      @newhirecredits = Newhirecredit.find(params[:id])
      @newhireinstitutions = Newhireinstitution.all
    end

    def update
      @newhirecredits = Newhirecredit.find(params[:id])

      if @newhirecredits.update_attributes(params[:newhirecredit])
         flash[:notice] = "Coursework successfully updated."
      	else
         flash[:notice] = "There was a problem updating the coursework."
      	end
    
      	redirect_to newhiredetails_path(params[:newhire_id])

    end 

    def new
    	
    	if (params.has_key?(:newhire_id))
        	session[:newhire_id] = params[:newhire_id]
   		end

   		@newhire = Newhire.find(params[:newhire_id])
    	@newhirecredits = Newhirecredit.new
    	@newhireinstitutions = Newhireinstitution.all
    end

    def destroy
	    @newhirecredits = Newhirecredit.find(params[:id])
	    @newhirecredits.destroy

	    #respond_to do |format|
	    #  format.html { redirect_to newhirecredentials_url }
	    #  format.json { head :ok }
	    #end

	    redirect_to newhiredetails_path(params[:newhire_id])
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
	    			 
	    			 if (params.has_key?(:source))
					  	redirect_to new_newhirecredit_path(:newhire_id => params[:id])
					  else
					  	redirect_to newhirecredits_path
					  end
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

				  if (params.has_key?(:source))
				  	redirect_to newhiredetails_path(params[:newhire_id])
				  else
				  	redirect_to newhirecredits_path
				  end

				end

	    else
	    	redirect_to newhirecomment_index_path
		end
    end
end
