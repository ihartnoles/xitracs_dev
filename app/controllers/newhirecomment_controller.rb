class NewhirecommentController < ApplicationController
  def index
  	@comment = Newhirecomment.new
  end

  def create
  	if (params[:commit] == 'Save') 
  		@comment = Newhirecomment.new(params[:newhirecomment])
  		@comment.newhire_id = session[:newhire_id]
  		@comment.created_by = current_user.id

	  	 if @comment.save
	  	 	flash[:notice] = "Comment added"
	  	 	redirect_to newhires_show_path
	  	 else
	  	 	flash[:notice] = "There was a problem saving the comments."
	  	 	redirect_to newhirecomments_path
	  	 end
	else
		redirect_to newhires_show_path
	end
  end

end
