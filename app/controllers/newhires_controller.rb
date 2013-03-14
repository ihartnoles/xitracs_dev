class NewhiresController < ApplicationController
  layout "precredentialing"

  def index  	
    	@newhire = Newhire.new    
  end

  def list  

     if  current_user.group.name == "chair"
      #if chair show only listings for the specific department
       @newhires = Newhire.where(:department_id => session[:department_id])
       @newhire_count = @newhires.count
    

     elsif current_user.group.name == "admin"

       #@newhires = Newhire.all
       #@newhire_count = @newhires.count     
       #@departments =  Department.where(:school_id => session[:school_id])

       redirect_to newhire_schools_path
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

  def savename
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
            redirect_to newhirecourses_path(:newhire_id => @newhire.id)
          else
            flash[:notice] = "Instructor NOT saved!"
            redirect_to newhirecourses_path(:newhire_id => @newhire.id)
          end  
      end
  end

  def departments
     #session[:school_id] = params[:school_id] if !params[:school_id].nil?
    

     if current_user.group.name == "admin"
        @departments =  Department.where(:school_id => params[:school_id]) 
        @school_name = School.find(params[:school_id]).description
     else
        @departments =  Department.where(:school_id => session[:school_id]) 
        @school_name = School.find(session[:school_id]).description
     end 
  end

  def schools
    @schools = School.where(:enabled => 1)
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

      @newhire_messages_added = Newhirereviewmessage.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

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
      
      #Tally total credis
      @total_credits=0.0
       if @newhire_credits_added.count > 0
         @newhire_credits_added.each do |idx|
            if idx.semester_credits == 1
              #calculate semester hours
              @total_credits = @total_credits + idx.course_credits.to_f
            else
              #calculate quarter hours
              @total_credits = @total_credits + (idx.course_credits.to_f * 2.0) / 3.0
            end
         end
      end


      @newhire_comments_added = Newhirecomment.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

      @newhire_messages_added = Newhirereviewmessage.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
      #@newhire_messages_added = Newhiresignoff.where(:newhire_id => params[:newhire_id], :course_id => params[:id])

      @reason = Reason.new
      @reviewreason = Reviewreason.all

     
      @newhire_reasons_added = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
      @newhire_review_state = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id]).map(&:review_state).join(',')

      
      @newhiresignoff=Newhiresignoff.new
      @newhire_signoffs = Newhiresignoff.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
       #if ( @newhire_reasons_added.count > 0)
       #   @newhirereason = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id]).first
          
       #else
       @newhirereason = Newhirereviewreason.new 
       #end        
     
  end

  def signoff
     @newhiresignoff=Newhiresignoff.new
     
     render :layout => 'simple'
  end


  
  def review_dialog
     @newhirereason = Newhirereviewreason.new
     @newhire_reasons_added = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id]) 

     render :layout => 'simple'
  end

  def save_review

    if (params[:newhirereviewreason][:review_state] == 2 && params[:newhirereviewreason][:review_comments].blank?) 

        flash[:notice] = 'Please enter a comment'
        redirect_to newhire_review_course_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])

    else
        @newhire_reviewreasons_added = Newhirereviewreason.where(:newhire_id => params[:newhirereviewreason][:newhire_id], :course_id => params[:newhirereviewreason][:course_id])
        @newhirereason = Newhirereviewreason.new 
        
        @newhirereason.course_id = params[:newhirereviewreason][:course_id]
        @newhirereason.newhire_id = params[:newhirereviewreason][:newhire_id]
        @newhirereason.reviewer_id = current_user.id
        @newhirereason.review_state = params[:newhirereviewreason][:review_state]
        
        if (!params[:newhirereviewreason][:review_comments].blank?)
         @newhirereason.review_comments = params[:newhirereviewreason][:review_comments]
        end
        
             
        @newhirereason.save

        
        #redirect_to newhire_review_course_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])
       end

    end
  end


  
  #def save_signoff
    
    #redirect_to
  #end

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
 
  def process_signoff
      @signoff = Newhiresignoff.new
      @signoff.newhire_id = params[:newhire_id]
      @signoff.course_id = params[:course_id]
      @signoff.user_id = current_user.id
      @signoff.signed_off = params[:newhiresignoff][:signed_off]
      @signoff.comment = params[:newhiresignoff][:comment]
      @signoff.save

      render :layout => 'simple'
      #redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
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


  def review_msg 
     #@message = Newhirereviewmessage.new    
  end

  def send_review_msg

     #set up the message object
     message = Newhirereviewmessage.new
     message.newhire_id = params[:newhire_id]
     message.course_id = params[:course_id]
     message.from = current_user.name
     message.to = params[:send_to]
     message.body = params[:newhirereviewmessage][:body]
     message.save

     #find the newhire
     @newhire = Newhire.find(params[:newhire_id])

     #set the msg argument     
     @msg = message.body
    
     #pass argumetns to the send_review_msg mailer function
     WizardMailer.send_review_msg(@newhire,@msg).deliver

     flash[:notice] = "Notification Sent!"

     #redirect_to newhiredetails_path(@newhire.id)
     redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
  end

end