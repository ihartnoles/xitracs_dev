class PrecredentialingController < ApplicationController
  
 

  def credentialsform
  	@reason = Reason.new
  	
    @reason.qualificationreason_id = Qualificationreason.find(:first).id
    @new_reason = true

    @credit = Credit.new  
    @credit.semester_credits = true;

    #@newhiredocument = Newhiredocument.new
  end

  def savecomments
  	@reason = Reason.new
  	@reason.update_attributes(params[:reason]) 
  	session[:reason_id] = @reason.id

  	redirect_to :action => 'credentialsform'
  end

   def file_upload

=begin
	doctype = params[:file_upload][:doc_type]
  name = params[:file_upload][:filename].original_filename
  directory = "public/data/"
  path = File.join(directory, params[:file_upload][:filename].original_filename)
  # write the file
  File.open(path, "wb") { |f| f.write(params[:file_upload][:filename].read) }

  d = Newhiredocument.new
  d.doc_type = params[:doc_type]
	d.name = name
	d.location = path
	d.save
=end
      
     #file = File.open('public/data/test.txt')

     #path = params[:file_upload][:my_file].path
     
     file = File.open(params[:file_upload][:my_file].original_filename)

     uploader = MyUploader.new
     uploader.store!(file)

		flash[:notice] = "File has been uploaded successfully"

		redirect_to :action => 'credentialsform'

  end
end



