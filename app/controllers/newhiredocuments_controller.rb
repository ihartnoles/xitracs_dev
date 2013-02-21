class NewhiredocumentsController < ApplicationController


  def index
  	@newhiredocument = Newhiredocument.new

  	#@newhiredoctypes= Newhiredoctype.new
  end

  def create
 	if !params[:newhiredoctype_ids].nil?
	  	params[:newhiredoctype_ids].split(",") do |idx|
	  		@newhiredocument = Newhiredocument.new(:newhiredoctype_id => idx, :newhire_id => session[:newhire_id])
	  		@newhiredocument.save

	  		if @newhiredocument.save
	  			flash[:notice] = "Documents submitted have been saved."
	  		else
	  			flash[:notice] = "There was a problem saving Documents"
	  			#redirect_to newhiredocuments_path
	  		end 
	  	end	
	 else
	 	flash[:notice] = "No Docs have been submitted!"
	 	#redirect_to newhiredocuments_path
	 end


	 #if params[:upload_docs] == 'Yes'
	 #	redirect_to '/newhiredocuments/uploadform'
	 #else
	 	#TO DO: redirect to instructor credential radio boxes
	 	redirect_to newhiredocuments_path
	 #end

  end 

  def uploadform
  	
  	
  end

  def upload
	  #doctype = params[:file_upload][:doc_type]
	  name = params[:file_upload][:filename].original_filename
	  directory = "public/data/"
	  path = File.join(directory, params[:file_upload][:filename].original_filename)
	  # write the file
	  File.open(path, "wb") { |f| f.write(params[:file_upload][:filename].read) }

	  d = Newhiredocument.new
	  #d.doc_type = params[:doc_type]
		d.name = name
		d.location = path
		d.newhiredoctype_id = 
		d.save
  end

end
