class NewhiredocumentsController < ApplicationController


  def index
  	@newhiredocument = Newhiredocument.new
  	@newhiredoctypes = Newhiredoctype.new
    @newhire_docs_added = Newhiredocument.where(:newhire_id => session[:newhire_id])
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
	 	redirect_to newhirecredentials_path
	 #end

  end 

  def edit
    @newhiredocument = Newhiredocument.find(params[:id])
  end

  def update
  end

  def uploadform
  	@doc_type = params[:doc_type]
  	@docname  = Newhiredoctype.find(params[:doc_type]).name
  	render :layout => 'simple'
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

     	redirect_to newhiredocuments_uploadstatus_path
  end

  def show
  	render :layout => 'simple'
  end
end
