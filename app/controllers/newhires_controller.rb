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
     #@reviewed_by_provost = Newhirereviewreason.where(:newhire_id => params[:id], :course_id =>  params[:course_id], :review_state => "1")
  end

  def save_signoff
      signoff = Newhiresignoff.new
      signoff.newhire_id = params[:newhire_id]
      signoff.course_id = params[:course_id]
      signoff.user_id = current_user.id
      signoff.signed_off = params[:newhiresignoff][:signed_off]
      signoff.comment = params[:newhiresignoff][:comment]
      
      if params[:newhiresignoff][:signed_off] == "1"
        @subject = "New Hire Signoff"
        signoff.sentto_id = params[:send_to][:notify]
      else
        @subject = "Corrections Needed!"
        signoff.sentto_id = params[:send_to][:correct]
      end

      signoff.save

      #find the newhire
      @newhire = Newhire.find(params[:newhire_id])

      #set the msg argument     
      @msg = signoff.comment
     



      #@sendto = "REALZ@fau.edu"
      @sendto = User.find(signoff.sentto_id).name

      #pass argumetns to the send_review_msg mailer function
      WizardMailer.send_review_msg(@newhire,@subject,@msg,@sendto).deliver

      flash[:notice] = "Signoff processed!"
      
       render :layout => 'simple'
      #redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
  end

  def delete_review
      reviewreason = Newhirereviewreason.find(params[:id])
      reviewreason.destroy

      flash[:notice] = "Review comment deleted!"

      redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
  end

  
  def delete_signoff
      signoff = Newhiresignoff.find(params[:id])
      signoff.destroy

      flash[:notice] = "Signoff entry deleted!"

      redirect_to newhire_review_course_path(:newhire_id => params[:newhire_id], :id => params[:course_id])
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
      

      #1=admin 2=dean 3=chair    
     if current_user.group.name == "admin"
        @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users'])     
        @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users'])     
     elsif current_user.group.name == "dean"
        #notify provost (admin)          
        @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where group_id=1',{:sid => session[:school_id]}])

        #chairs for each department
        @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where department_id = :did and group_id=3',{:did => session[:department_id] }])       
     else
        #deans for the school
        @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where school_id = :sid and group_id=2',{:sid => session[:school_id], :did => session[:department_id] }])       
        
        #chairs for each department
        @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where department_id = :did and group_id=3',{:did => session[:department_id] }])  
     end 
   
     render :layout => 'simple'
  end

  def review_msg 
     @newhire = Newhire.find(params[:newhire_id])
     @newhire_dept = Department.find(@newhire.department_id)  
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
  
  def review_dialog
     @newhirereason = Newhirereviewreason.new
     @newhire_reasons_added = Newhirereviewreason.where(:newhire_id => params[:newhire_id], :course_id => params[:id]) 

     render :layout => 'simple'
  end

  def save_review

    if (params[:newhirereviewreason][:review_state] == 2 && params[:newhirereviewreason][:review_comments].blank?) 

        flash[:alert] = 'Please enter a comment'
        redirect_to newhires_review_dialog_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])
    
    elsif (params[:newhirereviewreason][:review_state].blank? )
        
        flash[:alert] = 'Please select a status'
        redirect_to newhires_review_dialog_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])

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

     #render :layout => 'simple'
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
         
          @newhirereason.course_id = params[:newhirereviewreason][:course_id]
          @newhirereason.newhire_id = params[:newhirereviewreason][:newhire_id]
          @newhirereason.reviewer_id = current_user.id
          @newhirereason.review_state = params[:newhirereviewreason][:review_state]
          
          if (!params[:newhirereviewreason][:review_comments].blank?)
           @newhirereason.review_comments = params[:newhirereviewreason][:review_comments]
          end
          
                   
          @newhirereason.save

       
          redirect_to newhire_review_course_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])
      end     
  end 
 
 

  

end