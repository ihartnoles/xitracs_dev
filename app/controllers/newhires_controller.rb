class NewhiresController < ApplicationController
    
  def index  	
    	@newhire = Newhire.new    
  end

  def list  

     if  current_user.group.name == "chair"
      #if chair show only listings for the specific department
       @newhires = Newhire.where(:department_id => session[:department_id])
       @newhire_count = @newhires.count
    

     elsif current_user.group.name == "admin"

       @newhires = Newhire.all
       @newhire_count = @newhires.count     
       @departments =  Department.where(:school_id => session[:school_id])

     else
      
      #otherwise you are dean OR admin and you need to be able to see list of dept.
       redirect_to  newhire_showdepartments_path

       #@newhires = Newhire.all
       #@newhire_count = @newhires.count     
       #@departments =  Department.where(:school_id => session[:school_id])
     end
  end

  def list_by_dept
     @newhires = Newhire.where(:department_id => params[:department_id])
     @newhire_count = @newhires.count
  end

  def list_by_school
     @newhires = Newhire.where(:school_id => params[:school_id])
     @newhire_count = @newhires.count
  end

  def showcourses
     @newhire = Newhire.find(params[:id])
     @newhirecourses = Newhirecourse.where(:newhire_id => params[:id])   
     @newhire_dept = Department.find(@newhire.department_id)  
     @newhiredocuments = Newhiredocument.where(:newhire_id => params[:id])
  end

  def departments
     #session[:school_id] = params[:school_id] if !params[:school_id].nil?
     @departments =  Department.where(:school_id => session[:school_id]) 
  end


  def edit
      @newhire = Newhire.find(params[:id])
      @newhirecourses = Newhirecourse.where(:newhire_id => params[:id])
      @newhiredocuments = Newhiredocument.where(:newhire_id => params[:id])
      #todo newhirecredentials
  end

  def displaydetails
      @newhire = Newhire.find(params[:id])
      
      @newhirecourses = Newhirecourse.where(:newhire_id => params[:id])

      @newhiredocuments = Newhiredocument.where(:newhire_id => params[:id])

      @newhire_dept = Department.find(@newhire.department_id)
      
      @newhirecredentials = Newhirecredential.where(:newhire_id => params[:id])

      @newhire_credits_added  = Newhirecredit.where(:newhire_id => params[:id])
      
      @newhire_comments_added = Newhirecomment.where(:newhire_id => params[:id])

      #pull user id to for @credentialed_bu
      user_id = @newhire_comments_added.map(&:user_id)
      @credentialed_by = User.find(user_id).map(&:name).join("")

      @reason = Reason.new
      @newhirereason = Newhirereason.new
      @reviewreason = Reviewreason.all

      @newhire_review_reason = Newhirereason.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
  end

  def review_course
      @newhire = Newhire.find(params[:newhire_id])
      
      @newhire_course_to_review = Newhirecourse.find(params[:id])

      @newhirecourses = Newhirecourse.where(:newhire_id => params[:newhire_id])

      @newhiredocuments = Newhiredocument.where(:newhire_id => params[:newhire_id])

      @newhire_dept = Department.find(@newhire.department_id)
      
      @newhirecredentials = Newhirecredential.where(:newhire_id => params[:newhire_id])

      @newhire_credits_added  = Newhirecredit.where(:newhire_id => params[:newhire_id])
      
      @newhire_comments_added = Newhirecomment.where(:newhire_id => params[:newhire_id])

      #pull user id to for @credentialed
      user_id = @newhire_comments_added.map(&:user_id)
      @credentialed_by = User.find(user_id).map(&:name).join("")

      @reason = Reason.new
      @reviewreason = Reviewreason.all

      #if (@reviewreason != nil)
        #@reviewreason_ids = @reviewreason.reviewreason_ids      
        #@credits = Credit.where(:faculty_id => @faculty.id)        
      #end  
      
      #begin
       @newhire_reasons_added = Newhirereason.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

       @newhire_review_state = Newhirereason.where(:newhire_id => params[:newhire_id], :course_id => params[:id]).map(&:review_state).join(',')

       if (params.has_key?(:newhirereason_id))
          @newhirereason = Newhirereason.find(params[:newhirereason_id])
       else
          @newhirereason = Newhirereason.new 
       end
        
      #rescue
        #@newhirereason = Newhirereason.new
      #end
  end

  def approve_course
    if (params[:commit] == 'Submit')
      #if (params[:apply_comments_to_all])
      #  apply_comments_to_all = params[:apply_comments_to_all]
      #  params.delete(:apply_comments_to_all)
      #end
      
      #@newhirereason = Newhirereason.new
     
      #@newhirereason = Newhirereason.find(params[:newhirereason][:newhirereason_ids])
       
       if (params.has_key?(:newhirereason_id))
          @newhirereason = Newhirereason.find(params[:newhirereason_id])
       else
          @newhirereason = Newhirereason.new 
       end

      params[:newhirereason][:reviewreason_ids] ||= [] # Handle condition where all checkboxes are unchecked. This will remove previous entries from db
      @newhirereason.qualificationreason_id = params[:newhirereason][:reviewreason_ids].to_s
      @newhirereason.course_id = params[:newhirereason][:course_id]
      @newhirereason.newhire_id = params[:newhirereason][:newhire_id]
      @newhirereason.reviewer_id = current_user.id
      @newhirereason.review_state = params[:newhirereason][:review_state]
      
      if (!params[:newhirereason][:review_comments].blank?)
       @newhirereason.review_comments = params[:newhirereason][:review_comments]
      end
      
      

      #if (!apply_comments_to_all.nil?) 
       # reasons = Newhirereason.where(:newhire_id => params[:newhirereason][:newhire_id])
       #reasons.each do |r|
       #   if (r.review_state != Reason.review_passed)
       #     r.update_attributes(:review_comments => params[:newhirereason][:review_comments]) 
       #     r.update_attributes(:reviewer_id => params[:newhirereason][:reviewer_id]) 
       #   end
       # end
      #end
      
      @newhirereason.save

    #  redirect_to :action => 'approve_course'  
    # else
    #  @faculty = Faculty.find(params[:faculty_id])
    #  @course = Course.find(params[:course_id])
    #  @reason = Reason.where(:faculty_id => @faculty.id, :course_id => @course.id).first
    #  if (@reason != nil)
    #    @reviewreason_ids = @reason.reviewreason_ids      
    #    @credits = Credit.where(:faculty_id => @faculty.id)        
    #  end  
    #  session[:faculty_id] = params[:faculty_id]
    #  session[:course_id] = params[:course_id]
      redirect_to newhire_review_course_path(:newhire_id => params[:newhirereason][:newhire_id], :id => params[:newhirereason][:course_id])
     end
  end 

  def process_justification_deansignoff
    #@faculty = Faculty.find(session[:faculty_id])
    #@course = Course.find(session[:course_id])
    #@reason = Reason.find(session[:reason_id])   
    #if (params.has_key?(params[:newhirereason][:id]))
    #   @newhirereason = Newhirereason.find(params[:newhirereason][:id])
    #else 

       @newhire_reasons_added = Newhirereason.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
     
       if (params.has_key?(:newhirereason_id))
          @newhirereason = Newhirereason.find(params[:newhirereason_id])
       else
          @newhirereason = Newhirereason.new 
       end  
    
      @newhirereason.dean_id = current_user.id
      @newhirereason.newhire_id = params[:newhire_id]
      @newhirereason.course_id = params[:course_id]
      @newhirereason.dean_signoff = params[:newhirereason][:dean_signoff]
      @newhirereason.dean_comments = params[:newhirereason][:dean_comments]
   
   #if (params.has_key?(params[:newhirereason][:id]))
     
   #   @newhirereason.update_attributes(:dean_signoff => params[:dean_signoff]) 
   #   @newhirereason.update_attributes(:dean_comments => params[:dean_comments])
   #else
       @newhirereason.save
   #end
     # @reason.update_attributes(params[:reason])
    
     redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
  end

  def create
       if ( params[:first_name].blank? || params[:last_name].blank? ) 
          flash[:notice] = 'Please provide both a firstname and a lastname'
          redirect_to newhires_path
        else
  	      @newhire = Newhire.new(:first_name => params[:first_name], :middle_name => params[:middle_name],:last_name =>params[:last_name], :school_id => session[:school_id], :department_id => session[:department_id])
		  
          if params[:middle_name].blank? 
          	 @newhire.middle_name = nil
          else 
          	 @newhire.middle_name = params[:middle_name]
          end

      	  if @newhire.save
      	    session[:newhire_id] = @newhire.id
            session[:newhire_info] = @newhire
      	    #redirect_to next_wizard_path
             flash[:notice] = "Instructor successfully created."
      	    redirect_to newhirecourses_path 
      	  else
      	    redirect_to newhirecourses_path
      	  end	 
       end
  end


  def send_review_email
    @newhire = Newhire.find(params[:newhire_id])
    WizardMailer.send_review_email(@newhire).deliver

     flash[:notice] = "Notification sent to Review Team"

     redirect_to newhiredetails_path(@newhire.id)
  end

end