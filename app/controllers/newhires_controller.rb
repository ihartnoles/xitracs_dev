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
      #user_id = @newhire_comments_added.map(&:user_id)
      #@credentialed_by = User.find(user_id).map(&:name).join("")

      @reason = Reason.new
      @newhirereason = Newhirereason.new
      @reviewreason = Reviewreason.all

      @newhire_review_reason = Newhirereason.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
  end

  def review_course
      @newhire = Newhire.find(params[:newhire_id])
      
      @newhire_course_to_review = Newhirecourse.find(params[:id])

      @newhirecourses = Newhirecourse.where(:newhire_id => params[:newhire_id])

      @newhiredocuments = Newhiredocument.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

      @newhire_dept = Department.find(@newhire.department_id)
      
      @newhirecredentials = Newhirecredential.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

      @newhire_credits_added  = Newhirecredit.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
      
      @newhire_comments_added = Newhirecomment.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

     

      @reason = Reason.new
      @reviewreason = Reviewreason.all

     
       @newhire_reasons_added = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

       @newhire_review_state = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id]).map(&:review_state).join(',')

       
       #if ( @newhire_reasons_added.count > 0)
       #   @newhirereason = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id]).first
          
       #else
          @newhirereason = Newhirereviewreason.new 
       #end        
     
  end

  def approve_course
    if (params[:commit] == 'Submit')
     

      #if review status is NOT PASSED then require comments!
      if (params[:newhirereviewreason][:review_state] == 2 && params[:newhirereviewreason][:review_comments].blank?) 

          flash[:notice] = 'Please enter a comment'
          redirect_to newhire_review_course_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])

      else
           @newhire_reviewreasons_added = Newhirereviewreason.where(:newhire_id => params[:newhirereviewreason][:newhire_id], :course_id => params[:newhirereviewreason][:course_id])
           
          
           #if ( @newhire_reviewreasons_added.count > 0)
           #   @newhirereason = @newhire_reviewreasons_added.first
           #else
              @newhirereason = Newhirereviewreason.new 
           #end

          #params[:newhirereason][:qualificationreason_ids] ||= [] # Handle condition where all checkboxes are unchecked. This will remove previous entries from db
          #@newhirereason.qualificationreason_id = params[:newhirereason][:qualificationreason_ids].join(",")
          @newhirereason.course_id = params[:newhirereviewreason][:course_id]
          @newhirereason.newhire_id = params[:newhirereviewreason][:newhire_id]
          @newhirereason.reviewer_id = current_user.id
          @newhirereason.review_state = params[:newhirereviewreason][:review_state]
          
          if (!params[:newhirereviewreason][:review_comments].blank?)
           @newhirereason.review_comments = params[:newhirereviewreason][:review_comments]
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

       
          redirect_to newhire_review_course_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])
         end

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
 
  def review_msg 
     @message = Newhirereviewmessage.new    
  end

  def send_review_msg

     #set up the message object
     message = Newhirereviewmessage.new
     message.newhire_id = params[:newhire_id]
     message.course_id = params[:course_id]
     message.from = current_user.name
     message.to = 'TEST TO'
     message.body = params[:newhirereviewmessage][:body]
     message.save

     #find the newhire
     @newhire = Newhire.find(params[:newhire_id])

     #set the msg argument     
     @msg = message.body
    
     #pass argumetns to the send_review_msg mailer function
     WizardMailer.send_review_msg(@newhire,@msg).deliver

     flash[:notice] = "Notification sent to Review Team"

     redirect_to newhiredetails_path(@newhire.id)
  end

end