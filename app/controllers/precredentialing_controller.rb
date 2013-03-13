class PrecredentialingController < ApplicationController
  
  layout "precredentialing"
 

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
       	#doctype = params[:file_upload][:doc_type]
        # get the file name
        name = params[:file_upload][:filename].original_filename

        #gather new hire info
        newhirelname = Newhire.find(session[:newhire_id]).last_name
        newhirefname = Newhire.find(session[:newhire_id]).first_name
        newhireid    = Newhire.find(session[:newhire_id]).id
        
        #determine doc type
        doctype     = params[:doc_type]
         case doctype
            when '1' then doctypedir = 'transcript'
            when '2' then doctypedir = 'evaluation'
            when '3' then doctypedir = 'cv'
            when '4' then doctypedir = 'syllabus'
            when '5' then doctypedir = 'offerletter'
         end 
       
        #set the dynamic directory name
        dir = "public/data/#{newhirelname}_#{newhirefname}_#{newhireid}/#{doctypedir}"
        
        #create the file path
        path = File.join(dir, params[:file_upload][:filename].original_filename)
        
        #create the directory if it doesn't exist
        unless File.directory?(dir)
          FileUtils.mkdir_p(dir)
        end 
       
        # write the file
        File.open(path, "wb") { |f| f.write(params[:file_upload][:filename].read) }

        d = Newhiredocument.new
        #d.doc_type = params[:doc_type]
      	d.name = name
      	d.location = path
        d.newhiredoctype_id = params[:doc_type]
        d.newhire_id = session[:newhire_id]
      	d.save

       	flash[:notice] = "File has been uploaded successfully"

     		redirect_to :action => 'credentialsform'
  end
end



