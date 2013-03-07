class NewhirecommentController < ApplicationController
  def index
    @newhire = Newhire.find(session[:newhire_id])
  	@comment = Newhirecomment.new
  end

  def create
  	if (params[:commit] == 'Save') 
  		@comment = Newhirecomment.new(params[:newhirecomment])
  		@comment.newhire_id = session[:newhire_id]
  		@comment.user_id = current_user.id

	  	 if @comment.save
	  	 	flash[:notice] = "Comment added"
        flash[:notice] = "You will need to upload documents for each course!"
	  	 	#redirect_to newhires_show_path
	  	 else
	  	 	flash[:notice] = "There was a problem saving the comments."
	  	 	#redirect_to newhirecomments_path
	  	 end

       if (params.has_key?(:source))
          redirect_to newhiredetails_path(params[:newhire_id])
       else
          #redirect_to newhires_list_path
          redirect_to newhiredetails_path(:id => params[:newhire_id])
       end


  	else
  		#redirect_to newhires_list_path
      #newhiredetails_path(:id => params[:newhire_id])
      redirect_to '/newhires/#{params[:newhire_id]}/displaydetails' 


  	end
  end

  def new
     if (params.has_key?(:newhire_id))
        session[:newhire_id] = params[:newhire_id]
     end
      @newhire = Newhire.find(params[:newhire_id])
      @comment = Newhirecomment.new
  end

  def destroy
    @comment = Newhirecomment.find(params[:id])
    @comment.destroy

    #respond_to do |format|
    #  format.html { redirect_to newhirecredentials_url }
    #  format.json { head :ok }
    #end

    redirect_to newhiredetails_path(params[:newhire_id])
  end

  def edit
    @newhire = Newhire.find(params[:id])
    @comment = Newhirecomment.find(params[:id])
  end


  def update
    @comment = Newhirecomment.find(params[:id])

     if @comment.update_attributes(params[:newhirecomment])
        flash[:notice] = "Comment successfully updated."
     else
     	flash[:notice] = "There was a problem updating the comment."
     end
     redirect_to newhiredetails_path(params[:newhire_id])
  end
end
