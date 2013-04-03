class NewhiresController < ApplicationController
  protect_from_forgery :except => :assign_to

  layout "precredentialing"

  def index  	
    	@newhire = Newhire.new    
  end

  def update
      @newhire = Newhire.find(params[:id])

     if @newhire.update_attributes(params[:newhire])
        flash[:notice] = "New hire name updated."
     else
        flash[:notice] = "There was a problem updating the new hire name."
     end
     
     #redirect_to newhiredetails_path(params[:newhire_id])
     #redirect_to newhires_list_path
     #redirect_to  newhire_listbydept_path(:department_id => params[:department_id])
     redirect_to '/newhires/list_pending'
  end

  def list  

     if  current_user.group.name == "chair"
      #if chair show only listings for the specific department
       #@newhires = Newhire.where(:department_id => session[:department_id], :semester_id => session[:semester_id])
       @newhires = Newhire.find_by_sql(["SELECT
                                                  nh.id
                                                , nh.first_name
                                                , nh.middle_name
                                                , nh.last_name
                                                , nh.department_id
                                                , nh.school_id
                                                , nh.created_at
                                                , nh.updated_at
                                                , nhc.assigned_to
                                                , nhc.id as course_id
                                                , nhc.name
                                                , nhc.final_approval
                                                FROM
                                                    newhires nh
                                                    INNER JOIN newhirecourses nhc
                                                        ON (nh.id = nhc.newhire_id)
                                                 WHERE 
                                                     nh.department_id = :did
                                                 AND nhc.semester_id = :sem_id", {:did => session[:department_id]  , :sem_id => session[:semester_id] } ])
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

  def delete_newhire
     #find the newhire
     newhire = Newhire.where(params[:id])
     
     #start clearing out the records
     del_docs = Newhiredocument.destroy_all(:newhire_id => params[:id])
     del_credentials = Newhirecredential.destroy_all(:newhire_id => params[:id])
     del_courses = Newhirecourse.destroy_all(:newhire_id => params[:id])
     del_reviewreasons = Newhirereviewreason.destroy_all(:newhire_id => params[:id])
     del_signoffs = Newhiresignoff.destroy_all(:newhire_id => params[:id])

     #delete the newhire
     newhire.destroy(params[:id])

     flash[:notice] = "New hire deleted!"

     if current_user.group.name == "chair" 
      redirect_to '/newhires/list_pending'
     else 
      redirect_to '/newhires/list_pending'
      #redirect_to  newhires_list_by_dept_path(:department_id => params[:dept_id])
     end 

  end

  def list_pending
    
    #To Do: determine list type to display

    if current_user.group.name == "admin" 
      
       @send_to_notify=User.find_by_sql(["select id, concat(name,'@fau.edu') as displayname from users where name IN ('afradkin','jdiaka','pscarlat','koku','mwalsh8')"])

      if (params[:atm])
        #ASSIGNED TO ME ADMIN
        @newhires = Newhire.find_by_sql(["SELECT
                                                nh.id
                                              , nh.first_name
                                              , nh.middle_name
                                              , nh.last_name
                                              , nh.department_id
                                              , nh.school_id
                                              , nh.created_at
                                              , nh.updated_at
                                              , nhc.assigned_to
                                              , nhc.id as course_id
                                              , nhc.name
                                              , nhc.final_approval
                                          FROM
                                              newhires nh
                                              INNER JOIN newhirecourses nhc
                                                  ON (nh.id = nhc.newhire_id)
                                           WHERE nhc.assigned_to = :cid 
                                           AND nhc.semester_id = :sem_id", {:cid => current_user.id , :sem_id => session[:semester_id] } ])
      else
        @newhires =  Newhire.find_by_sql(["SELECT
                                                nh.id
                                              , nh.first_name
                                              , nh.middle_name
                                              , nh.last_name
                                              , nh.department_id
                                              , nh.school_id
                                              , nh.created_at
                                              , nh.updated_at
                                              , nhc.assigned_to
                                              , nhc.id as course_id
                                              , nhc.name
                                              , nhc.final_approval
                                          FROM
                                              newhires nh
                                              INNER JOIN newhirecourses nhc
                                                  ON (nh.id = nhc.newhire_id)
                                           WHERE nhc.semester_id = :sem_id", {:sem_id => session[:semester_id] } ])
      end

    elsif current_user.group.name == "dean"
       if (params[:atm])
             #ASSIGNED TO ME DEAN
              @newhires = Newhire.find_by_sql(["SELECT
                                                  nh.id
                                                , nh.first_name
                                                , nh.middle_name
                                                , nh.last_name
                                                , nh.department_id
                                                , nh.school_id
                                                , nh.created_at
                                                , nh.updated_at
                                                , nhc.assigned_to
                                                , nhc.id as course_id
                                                , nhc.name
                                                , nhc.final_approval
                                                FROM
                                                    newhires nh
                                                    INNER JOIN newhirecourses nhc
                                                        ON (nh.id = nhc.newhire_id)
                                                 WHERE nhc.assigned_to = :cid
                                                 AND nh.school_id = :schoolid
                                                 AND nhc.semester_id = :sem_id", {:cid => current_user.id , :schoolid => session[:school_id] , :sem_id => session[:semester_id] } ])
       else
          @newhires = Newhire.find_by_sql(["SELECT
                                                  nh.id
                                                , nh.first_name
                                                , nh.middle_name
                                                , nh.last_name
                                                , nh.department_id
                                                , nh.school_id
                                                , nh.created_at
                                                , nh.updated_at
                                                , nhc.assigned_to
                                                , nhc.id as course_id
                                                , nhc.name
                                                , nhc.final_approval
                                                FROM
                                                    newhires nh
                                                    INNER JOIN newhirecourses nhc
                                                        ON (nh.id = nhc.newhire_id)
                                                 WHERE 
                                                     nh.school_id = :schoolid
                                                 AND nhc.semester_id = :sem_id", {:schoolid => session[:school_id] , :sem_id => session[:semester_id] } ])
       end
    else
       #ASSIGNED TO CHAIRS/AUTHORIZED USERS
       @newhires = Newhire.find_by_sql(["SELECT
                                                  nh.id
                                                , nh.first_name
                                                , nh.middle_name
                                                , nh.last_name
                                                , nh.department_id
                                                , nh.school_id
                                                , nh.created_at
                                                , nh.updated_at
                                                , nhc.assigned_to
                                                , nhc.id as course_id
                                                , nhc.name
                                                , nhc.final_approval
                                                FROM
                                                    newhires nh
                                                    INNER JOIN newhirecourses nhc
                                                        ON (nh.id = nhc.newhire_id)
                                                 WHERE nhc.assigned_to = :cid
                                                 AND nh.department_id = :did
                                                 AND nhc.semester_id = :sem_id", {:cid => current_user.id , :did => session[:department_id]  , :sem_id => session[:semester_id] } ])
    end
    
    @newhire_count = @newhires.count
  end

  def list_by_dept
     @newhires = Newhire.where(:department_id => params[:department_id], :semester_id => session[:semester_id], :assigned_to => current_user.id)
     @newhire_count = @newhires.count
  end

  def list_by_school
     @newhires = Newhire.where(:school_id => params[:school_id], :semester_id => session[:semester_id])
     @newhire_count = @newhires.count
  end

  def showcourses
     @newhire = Newhire.find(params[:id])
     @newhirecourses = Newhirecourse.where(:newhire_id => params[:id])   
     @newhire_dept = Department.find(@newhire.department_id)  
     @newhiredocuments = Newhiredocument.where(:newhire_id => params[:id])

       
     #@reviewed_by_provost = Newhirereviewreason.where(:newhire_id => params[:id], :course_id =>  params[:course_id], :review_state => "1")
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
          @newhire = Newhire.new(:first_name => params[:first_name], 
                                 :middle_name => params[:middle_name],
                                 :last_name =>params[:last_name], 
                                 :semester_id => session[:semester_id],
                                 :school_id => session[:school_id], 
                                 :department_id => session[:department_id],
                                 :assigned_to => current_user.id)
      
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
    if current_user.group.name == "dean"
       @schools = School.where(:enabled => 1, :id => session[:school_id] )
    else
       @schools = School.where(:enabled => 1)
    end
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

  def assign_to
     newhirecourse = Newhirecourse.find(params[:id])

     newhirecourse.update_attributes(:assigned_to => params[:assigned_to])

     #flash[:notice] = 'We be bumpin'

     #redirect_to newhire_listpending_path
     render :nothing => true
  end

  def review_course
      @newhire = Newhire.find(params[:newhire_id])
      
      @newhire_course_to_review = Newhirecourse.find(params[:id])

      @newhirecourses = Newhirecourse.where(:newhire_id => params[:newhire_id])

      @newhiredocuments = Newhiredocument.where(:newhire_id => params[:newhire_id], :course_id => params[:id])
      
      @newhiredoctypes = Newhiredoctype.new

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
      
      @review_team = ['afradkin','jdiaka','pscarlat','koku']    
     
  end

  def signoff
    @newhiresignoff=Newhiresignoff.new
      

      #1=admin 2=dean 3=chair    
     if current_user.group.name == "admin"

        #provost_review = [ 'kwrigh59']
        #review_team = ['afradkin','jdiaka','pscarlat','koku','mwalsh8']

      if current_user.name == "kwrigh59"
        #notify review team
        @send_to_notify=User.find_by_sql(["select id, concat(name,'@fau.edu') as displayname from users where name = 'mwalsh8'"])    
         #send to dean for correction
        @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where school_id = :sid and permission_id=4',{:sid => Newhire.find(params[:newhire_id]).school_id, :did => Newhire.find(params[:newhire_id]).department_id }])       
      else
       
        if current_user.permission_id == 8
          #you are a review team member you can only send to Mary
          @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where name = "mwalsh8"'])
          @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where name = "mwalsh8"'])
        else
           #you are an admin you can send to anybody
          @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users'])     
          @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users'])     
        end
       
      end

     elsif current_user.group.name == "dean"
        #notify provost (admin)          
        #@send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where group_id=1',{:sid => session[:school_id]}])
        @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where name = "kwrigh59"'])

        #chairs for each department
        @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where department_id = :did and permission_id=2',{:did => Newhire.find(params[:newhire_id]).department_id }])       
     else

        if current_user.permission_id == 1
          #you are an AUTHORIZED USER so find CHAIRS to NOTIFY
          @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where department_id = :did and permission_id=2',{:did => Newhire.find(params[:newhire_id]).department_id }])       
        else
          #you are a CHAIR so find deans for the school
          @send_to_notify=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where school_id = :sid and permission_id=4',{:sid => session[:school_id], :did => Newhire.find(params[:newhire_id]).department_id }])       
          
        end
        #chairs for each department
        @send_to_correct=User.find_by_sql(['select id, concat(name,"@fau.edu") as displayname from users where department_id = :did and permission_id = 1',{:did => Newhire.find(params[:newhire_id]).department_id }])  
        
     end 
   
     render :layout => 'simple'
  end

  def review_msg 
     @newhire = Newhire.find(params[:newhire_id])
     @newhire_dept = Department.find(@newhire.department_id)  
  end

  def send_review_msg

     #find the newhire
     #@newhire = Newhire.find(params[:newhire_id])
     @newhire = Newhire.find(params[:newhirereviewreason][:newhire_id])

     #set up the message object
     @message = Newhirereviewreason.new
     @message.newhire_id = params[:newhirereviewreason][:newhire_id]
     @message.course_id = params[:newhirereviewreason][:course_id]
     @message.review_state = params[:newhirereviewreason][:review_state]
     #@message.from = current_user.name
     @message.reviewer_id = current_user.id
     @message.review_comments = params[:newhirereviewreason][:review_comments]
     @message.save

     @newhirename = @newhire.fullname

     @subject = "Credentialing Review Status Updated for #{@newhirename}"

     #set the msg argument     
     @msg = @message.review_comments

     @sendto = 'mwalsh8'
     @sentby = User.find(current_user.id).name

     @body = "A review has been entered for #{@newhirename}"
           
    
     #pass argumetns to the send_review_msg mailer function
     WizardMailer.send_msg(@newhire,@subject,@msg,@sendto,@body,@sentby).deliver

     #move the course over to Mary's queue
     newhirecourse = Newhirecourse.find(params[:newhirereviewreason][:course_id])
     newhirecourse.assigned_to = User.find_by_name('mwalsh8').id
     newhirecourse.save

     flash[:notice] = "Notification Sent!"

     render :layout => 'simple'
     #redirect_to newhire_review_course_path(:newhire_id => params[:newhirereviewreason][:newhire_id], :id => params[:newhirereviewreason][:course_id])
  end

  def save_signoff
          if !params[:newhiresignoff][:signed_off] && !params[:final_approval]
              
              flash[:alert] = "Please choose to signoff or return for corrections"

         else
            signoff = Newhiresignoff.new
            signoff.newhire_id = params[:newhire_id]
            signoff.course_id = params[:course_id]
            signoff.user_id = current_user.id
            signoff.signed_off = params[:newhiresignoff][:signed_off]
            signoff.comment = params[:newhiresignoff][:comment]
            signoff.user_type = current_user.group_id
            #signoff.user_type = Group.find(user.group_id).name.humanize
            @newhirename = Newhire.find(params[:newhire_id]).fullname

             if (params[:final_approval])
                  @subject = "Credentialing Completed for #{@newhirename}"
                  #signoff.final_approval = params[:newhiresignoff][:final_approval]
                  
                  save_final_approval = Newhirecourse.find(params[:course_id]).update_attribute(:final_approval, params[:final_approval])
                  
                  #need to pull CHAIR here
                  #@sendto = User.find(signoff.sentto_id).name
                  @user = User.find_by_sql(['select id, name from users where department_id = :did and permission_id = 2 limit 1',{:did => Newhire.find(params[:newhire_id]).department_id }])  
                  
                  @user.each { |x|
                       @sendto = x.name
                       signoff.sentto_id = x.id
                  }
                               
                  @body = "Credential has been met for  #{@newhirename}. You may proceed to hire."                    

                  flash[:notice] = "Final Approval processed!"
             else
                

                if params[:newhiresignoff][:signed_off] == "1"
                  @subject = "Credentialing Action Needed for #{@newhirename}"
                  signoff.sentto_id = params[:send_to][:notify]
                else
                  @subject = "Credentialing Action Needed for #{@newhirename}"
                  signoff.sentto_id = params[:send_to][:correct]
                end

                @sendto = User.find(signoff.sentto_id).name
                @body = "Credentials for  #{@newhirename} have been entered and are awaiting your signoff to proceed to the next stage of review.  Please log on to the wizard (sacs.eng.fau.edu), select 'First-time Adjunct & GTA Credentialing,' from the top menu bar and click on 'Listing' to see what is awaiting your action."
           
                flash[:notice] = "Signoff processed!"
             end

            signoff.save

            #find the newhire
            @newhire = Newhire.find(params[:newhire_id])
            @newhirecourse = Newhirecourse.find(params[:course_id])

            #TO DO: Find our Newhire and update assigned_to => params
            @newhirecourse.assigned_to =  signoff.sentto_id
            @newhirecourse.save
            
            #save our assigned_to value for Newhirecourse
            save_course_assigned_to = Newhirecourse.find(params[:course_id]).update_attribute(:assigned_to, signoff.sentto_id)

            #set the msg argument     
            @msg = signoff.comment

            @sentby = User.find(current_user.id).name

            #pass argumetns to the send_review_msg mailer function
            WizardMailer.send_msg(@newhire,@subject,@msg,@sendto,@body,@sentby).deliver
     
      end 
      render :layout => 'simple'
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