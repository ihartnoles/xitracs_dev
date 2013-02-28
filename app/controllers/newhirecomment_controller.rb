class NewhirecommentController < ApplicationController
  def index
  	@comment = Newhirecomment.new
  end

  def create
  	if (params[:commit] == 'Save') 
  		@comment = Newhirecomment.new(params[:newhirecomment])
  		@comment.newhire_id = session[:newhire_id]
  		@comment.user_id = current_user.id

	  	 if @comment.save
	  	 	flash[:notice] = "Comment added"
	  	 	#redirect_to newhires_show_path
	  	 else
	  	 	flash[:notice] = "There was a problem saving the comments."
	  	 	#redirect_to newhirecomments_path
	  	 end

       if (params.has_key?(:source))
          redirect_to newhiredetails_path(params[:newhire_id])
       else
          redirect_to newhires_show_path
       end


  	else
  		redirect_to newhires_show_path
  	end
  end

  def new
     if (params.has_key?(:newhire_id))
        session[:newhire_id] = params[:newhire_id]
     end

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