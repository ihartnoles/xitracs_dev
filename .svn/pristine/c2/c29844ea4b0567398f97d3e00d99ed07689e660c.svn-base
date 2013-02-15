class WizardController < ApplicationController
  
  before_filter :set_qualification_reasons
  
  @QR_TEACH_DIS = 0
  @QR_OTHER_COMMENTS = 0
  @QR_OTHER_COURSES = 0
  @QR_OTHER_COURSES_AND_COMMENTS = 0  
  @QR_MASTERS = 0
  @QR_BACHELORS = 0
  @QR_EXCEPTION = 0
    
  def course  
    @courses = Course.all.page params[:page]
  end
  
  def set_qualification_reasons
    # Fill in the global variables for use later 
    qualification_reasons = Qualificationreason.all
    t_index=0
    @QR_TEACH_DIS = qualification_reasons[t_index].id
    @QR_OTHER_COMMENTS = qualification_reasons[t_index+=1].id
    @QR_OTHER_COURSES = qualification_reasons[t_index+=1].id
    @QR_OTHER_COURSES_AND_COMMENTS = qualification_reasons[t_index+=1].id  
    @QR_MASTERS = qualification_reasons[t_index+=1].id 
    @QR_BACHELORS = qualification_reasons[t_index+=1].id
    @QR_EXCEPTION = qualification_reasons[t_index+=1].id
  end
 
  def department
    session[:school_id] = params[:school_id] if !params[:school_id].nil?
    @departments =  Department.where(:school_id => session[:school_id])  
  end
  
  def faculty
    sort_fields = { 'department' => :department_id, 
                    'last_name' => :last_name, 
                    'rank' => :rank_id,
                    'tenure' => :tenurestatus_id,
                    'completed' => :completed,
                    'reviewed' => :reviewed,
                    'degree' => :qualification_id}
    
    
    if (!params[:school_id].nil? && session[:group_name] != "chair")
      session[:search_mode] = "school"
    elsif (!params[:department_id].nil?)
      session[:search_mode] = "department"
    end
    
    session[:department_id] = params[:department_id].nil? ? session[:department_id] : params[:department_id]
    if (session[:department_id].nil?)
      logger.error("XXX: session[:department_id] was nil")
      session[:department_id] = current_user.department_id
    end
    
    if (session[:group_name] == "admin" && !params[:school_id].nil?)
      session[:school_id] = params[:school_id].to_i
    elsif (session[:school_id].nil?)
      session[:school_id] = current_user.school_id
    end
      
    # Remember the current page (so we can return to it after fininishing a faculty)
    if (!params[:page].nil?)
      session[:page] = params[:page]
    elsif (params[:dont_override].nil?)
      params[:page] = session[:page]
    end 

    # Remember the current sort key
    if (!params[:sort_by].nil?) 
      session[:sort_by] = params[:sort_by]
    elsif (session[:sort_by].nil?)
      session[:sort_by] = 'last_name'
    end
  
    # Remember the current sort direction
    if (!params[:sort_dir].nil?) 
      session[:sort_dir] = params[:sort_dir]
    elsif (session[:sort_dir].nil?)
      session[:sort_dir] = 'down' # changed to 'up' a few lines below
    end

    sort_by = sort_fields[session[:sort_by]]
    @sort_dir = session[:sort_dir] == 'up' ? 'down' : 'up' # Reverse the sort direction XXX : May sort opposite every time page loads
     
    # Limit by Semester
    section_ids = Section.where(:semester_id => session[:semester_id]).map {|row| row.id}
    sectionenrollment_faculty_ids = Sectionenrollment.where(:section_id => section_ids).map {|s| s.faculty_id}.uniq
              
    if (session[:group_name] == 'chair')
      department_ids = [current_user.department_id] # Chair can only see their department
    elsif (session[:search_mode] == "department") 
      department_ids =[session[:department_id]]
    else
      department_ids = Department.where(:school_id => session[:school_id]).map {|row| row.id}
    end
    if @sort_dir == 'up' 
      @faculties = Faculty.where(:department_id => department_ids, :id => sectionenrollment_faculty_ids).order(sort_by).order(:last_name).page params[:page]
    else
      @faculties = Faculty.where(:department_id => department_ids, :id => sectionenrollment_faculty_ids).order(sort_by).order(:last_name).reverse_order.page params[:page]
    end      
    
    session[:faculty_id] = nil
    session[:course_id] = nil
    session[:reason_id] = nil   

    # Chart Statistics
    
    department_list = department_ids.map {|d| d.to_s}.join(",")
    semester_id = session[:semester_id]
    result_c = ActiveRecord::Base.connection.select_one("select count(distinct f.id) count from faculties f, departments d, donesemesters ds, sectionenrollments se, sections s where ds.faculty_id = f.id and f.department_id = d.id  and se.faculty_id = f.id and se.section_id = s.id and s.semester_id = ds.semester_id and d.id in (#{department_list}) and ds.semester_id = #{semester_id} and ds.completed=1")
    @faculties_completed = result_c["count"].to_i
    result_nc = ActiveRecord::Base.connection.select_one("select count(distinct f.id) count from faculties f, departments d, donesemesters ds, sectionenrollments se, sections s where ds.faculty_id = f.id and f.department_id = d.id  and se.faculty_id = f.id and se.section_id = s.id and s.semester_id = ds.semester_id and d.id in (#{department_list}) and ds.semester_id = #{semester_id} and ds.completed=0")
    @faculties_not_completed = result_nc["count"].to_i
    result_r = ActiveRecord::Base.connection.select_one("select count(distinct f.id) count from faculties f, departments d, donesemesters ds, sectionenrollments se, sections s where ds.faculty_id = f.id and f.department_id = d.id  and se.faculty_id = f.id and se.section_id = s.id and s.semester_id = ds.semester_id and d.id in (#{department_list}) and ds.semester_id = #{semester_id} and ds.reviewed=1")
    @faculties_reviewed = result_r["count"].to_i
    result_nr = ActiveRecord::Base.connection.select_one("select count(distinct f.id) count from faculties f, departments d, donesemesters ds, sectionenrollments se, sections s where ds.faculty_id = f.id and f.department_id = d.id  and se.faculty_id = f.id and se.section_id = s.id and s.semester_id = ds.semester_id and d.id in (#{department_list}) and ds.semester_id = #{semester_id} and ds.reviewed=0")
    @faculties_not_reviewed = result_nr["count"].to_i

    if (@faculties_completed == 0 && @faculties_not_completed == 0)
      @percent_complete = 0
    else
      @percent_complete =  100 * @faculties_completed / (@faculties_completed + @faculties_not_completed)
    end
     if (@faculties_reviewed == 0 && @faculties_not_reviewed == 0)
      @percent_reviewed = 0
    else
      @percent_reviewed =  100 * @faculties_reviewed / (@faculties_reviewed + @faculties_not_reviewed)
    end
     
    data_table1 = GoogleVisualr::DataTable.new
    data_table1.new_column('string', 'Label')
    data_table1.new_column('number', '')
    data_table1.add_rows(2)
    data_table1.set_cell(0, 0, 'Completed')
    data_table1.set_cell(0, 1, @percent_complete) # 0.0001 = prevent division by zero
    data_table1.set_cell(1, 0, 'Not Completed')
    data_table1.set_cell(1, 1, 100 - @percent_complete) # 0.0001 = prevent division by zero
    opts1   = { :width => 300, :height => 100, :is3D => true}
    @chart_complete = GoogleVisualr::Interactive::PieChart.new(data_table1, opts1)
    
    data_table2 = GoogleVisualr::DataTable.new
    data_table2.new_column('string', 'Label')
    data_table2.new_column('number', '')
    data_table2.add_rows(2)
    data_table2.set_cell(0, 0, 'Reviewed')
    data_table2.set_cell(0, 1, @percent_reviewed) # 0.0001 = prevent division by zero
    data_table2.set_cell(1, 0, 'Not Reviewed')
    data_table2.set_cell(1, 1, 100 - @percent_reviewed) # 0.0001 = prevent division by zero
    opts2   = { :width => 300, :height => 100, :is3D => true}
    @chart_reviewed = GoogleVisualr::Interactive::PieChart.new(data_table2, opts2)        
  end

  def find
    if (params[:commit] == 'Search by ZNumber')
      if ((f=Faculty.find_by_znumber(params[:znumber])) != nil)
        redirect_to :action => 'show_courses_for', :faculty_id => f.id
      else  
        flash[:notice] = "Unknown Faculty Z Number: #{params[:znumber]}"
        redirect_to '/start'
      end
    elsif (params[:commit] == 'Search by Name')
      if ((f=Faculty.where(:last_name => params[:last_name].capitalize, :first_name => params[:first_name].capitalize, :department_id => params[:department_id])).count > 0)
        redirect_to :action => 'show_courses_for', :faculty_id => f.first.id
      else  
        flash[:notice] = "Unknown Faculty: #{params[:last_name]}, #{params[:first_name]} in #{params[:department_id]}"
        redirect_to '/start'
      end
    end
  end
  
  def show_courses_for
    session[:faculty_id] = params[:faculty_id].nil? ? session[:faculty_id] : params[:faculty_id]
    faculty_id = params[:faculty_id].nil? ? session[:faculty_id] : params[:faculty_id]
    section_ids = Sectionenrollment.where(:faculty_id => faculty_id).map {|row| row.section_id}
    course_ids = Section.where(:id => section_ids, :semester_id => session[:semester_id]).group(:course_id).map {|row| row.course_id}
    @courses = Course.where(:id => course_ids).page params[:page]
    @faculty = Faculty.find(session[:faculty_id])
    session[:course_id] = nil
    session[:reason_id] = nil   
  end

  def justify_course_for
    @faculty = Faculty.find(params[:faculty_id])
    @course = Course.find(params[:course_id])

    session[:faculty_id] = params[:faculty_id]
    session[:course_id] = params[:course_id]
    session[:reason_id] = nil   

    @reason = Reason.where(:faculty_id => @faculty.id, :course_id => @course.id)
    
    if @reason.count == 0 then 
        @reason = Reason.new
        @reason.faculty_id = params[:faculty_id]
        @reason.course_id = params[:course_id]
        @reason.qualificationreason_id = Qualificationreason.find(:first).id
        @new_reason = true
    else
        @reason = @reason[0]
        session[:reason_id] = nil
        @new_reason = false   
    end                                                                            
  end
  
  def show_course_summary
    @faculty = Faculty.find(params[:faculty_id])
    @course = Course.find(params[:course_id])
    @reason = Reason.where(:faculty_id => @faculty.id, :course_id => @course.id).first
    if (@reason != nil)
      @reviewreason_ids = @reason.reviewreason_ids      
      @credits = Credit.where(:faculty_id => @faculty.id)        
    end      
    render :layout => 'simple'
  end
  
  def approve_course_for
    if (params[:commit] == 'Submit')
      if (params[:apply_comments_to_all])
        apply_comments_to_all = params[:apply_comments_to_all]
        params.delete(:apply_comments_to_all)
      end
      reason = Reason.find(params[:reason][:id])
      params[:reason][:reviewreason_ids] ||= [] # Handle condition where all checkboxes are unchecked. This will remove previous entries from db
      params[:reason][:reviewer_id] = current_user.id
      reason.update_attributes(params[:reason]) if !current_user.ro
      if (!apply_comments_to_all.nil?) 
        reasons = Reason.where(:faculty_id => params[:reason][:faculty_id])
        reasons.each do |r|
          if (r.review_state != Reason.review_passed)
            r.update_attributes(:review_comments => params[:reason][:review_comments]) 
            r.update_attributes(:reviewer_id => params[:reason][:reviewer_id]) 
          end
        end
      end
      redirect_to :action => 'approve_course_done'  
    else
      @faculty = Faculty.find(params[:faculty_id])
      @course = Course.find(params[:course_id])
      @reason = Reason.where(:faculty_id => @faculty.id, :course_id => @course.id).first
      if (@reason != nil)
        @reviewreason_ids = @reason.reviewreason_ids      
        @credits = Credit.where(:faculty_id => @faculty.id)        
      end  
      session[:faculty_id] = params[:faculty_id]
      session[:course_id] = params[:course_id]
    end
  end
  
  def approve_course_done
    @faculty = Faculty.find(session[:faculty_id])
    @course = Course.find(session[:course_id])
    Donesemester.freshen_all(@faculty)
  end
  
  def process_justification
    @faculty = Faculty.find(session[:faculty_id])
    @course = Course.find(session[:course_id])

    params[:reason][:qualificationreason_id] = Qualificationreason.find_by_name(params[:qualificationreason_name]).id
   	params[:reason][:user_id] = current_user.id 
    if (params[:reason][:id] != '') 
      @reason = Reason.find(params[:reason][:id])
      @reason.update_attributes(params[:reason]) if !current_user.ro
    else
      @reason = Reason.create(params[:reason]) if !current_user.ro
    end
    session[:reason_id] = @reason.id
   
    if (@reason.qualificationreason_id == @QR_TEACH_DIS)
      redirect_to :action => 'process_justification_comments' # 'process_justification_done'
    elsif (@reason.qualificationreason_id == @QR_OTHER_COMMENTS)
      redirect_to :action => 'process_justification_comments'      
    elsif (@reason.qualificationreason_id == @QR_EXCEPTION)
      redirect_to :action => 'process_justification_exception'     
    else  
      redirect_to :action => 'process_justification_coursework'     
    end
  end
  
  def process_justification_exception
    @faculty = Faculty.find(session[:faculty_id])
    @course = Course.find(session[:course_id])
    @reason = Reason.find(session[:reason_id])
    
    if (params[:commit] == 'Done')
      redirect_to :action => 'process_justification_signoff_or_done'
    end 
  end
  
  
  def process_justification_comments
    @faculty = Faculty.find(session[:faculty_id])
    @course = Course.find(session[:course_id])
    @reason = Reason.find(session[:reason_id])
    
    if (params[:commit] == 'Next>' && !params[:reason][:comments].nil? && params[:reason][:comments].length > 0) 
      @reason.update_attributes(params[:reason]) if !current_user.ro
      redirect_to :action => 'process_justification_signoff_or_done'
    elsif (params[:commit] == 'Next>' && @reason.qualificationreason_id == @QR_TEACH_DIS)
      redirect_to :action => 'process_justification_signoff_or_done' # Comments are optional if reason is 'terminal degree in teaching discipline'
    else
      flash[:notice] = "Please provide Justification in the comments section"
    end
  end
  
  def process_justification_coursework
    @faculty = Faculty.find(session[:faculty_id])
    @course = Course.find(session[:course_id])
    @reason = Reason.where(:faculty_id => @faculty.id, :course_id => @course.id).first          
  
    if (params[:commit] == 'Add')
      Credit.create(params[:credit]) if !current_user.ro
    elsif (params[:commit] == 'Delete')
      Credit.delete(params[:credit][:id]) if !current_user.ro
    elsif (params[:commit] == 'Done')
      # XXX : Need to allow continuation only if comments are filled out for QR_COURSES_AND_COMMENTS
      
      redirect_to :action => 'process_justification_signoff_or_done'
    elsif (params[:commit] == 'Save')
      @reason.update_attributes(params[:reason]) if !current_user.ro
    end 
    @credits = Credit.where(:faculty_id => @faculty.id)        
    @credit = Credit.new(:faculty_id => @faculty.id)  
    @credit.semester_credits = true;
  end 
  
  def process_justification_signoff_or_done
    if (session[:group_name] == "dean" || session[:group_name] == "admin") 
        redirect_to :action => 'process_justification_deansignoff'
    else
        redirect_to :action => 'process_justification_done'
    end
  end
 
  def process_justification_deansignoff
    @faculty = Faculty.find(session[:faculty_id])
    @course = Course.find(session[:course_id])
    @reason = Reason.find(session[:reason_id])   
    if (params[:commit] == 'Submit')
      params[:reason][:dean_id] = current_user.id
      @reason.update_attributes(params[:reason])
      redirect_to :action => 'process_justification_done'
    end   
  end
  
  def process_justification_done
    @faculty = Faculty.find(session[:faculty_id])
    @course = Course.find(session[:course_id])
    @reason = Reason.find(session[:reason_id])
    
    # Mark the section enrollments for that course taught by that faculty as completed 
    # based on type of reason. I.e. if courses specified, then credits must add to > 18
    if ([@QR_OTHER_COURSES, @QR_OTHER_COURSES_AND_COMMENTS, @QR_MASTERS, @QR_BACHELORS].index(@reason.qualificationreason_id) != nil)
      total_credits=0.0
      Credit.where(:faculty_id => @faculty.id).map do |credit| 
        if credit.semester_credits
          total_credits = total_credits + credit.course_credits.to_f
        else 
          total_credits = total_credits + (credit.course_credits.to_f * 2.0) / 3.0 # Convert quarter to semester 
        end
				#logger.error("XXX: #{total_credits} #{credit.course_credits.to_f} #{credit.semester_credits}")
      end
      @course_justification_completed = total_credits >= 18       
    elsif ([@QR_EXCEPTION].index(@reason.qualificationreason_id) != nil)
      # Exception reason will always make a course not-completed status
      # Changed 6/6/2012 - Exceptions are considered completed
      @course_justification_completed = true     
    else
      @course_justification_completed = true
    end   
    
    # Update all sections regardless of semester for that faculty+course combo
    t_sections = Section.where(:course_id => @course.id).map  {|row| row.id}
    t_section_enrollments = Sectionenrollment.where(:section_id => t_sections, :faculty_id => @faculty.id)
    t_section_enrollments.each {|s| s.update_attributes(:completed => true)}
    Donesemester.freshen_all(@faculty)
    @faculty_completed = Donesemester.is_done?(@faculty, Semester.find(session[:semester_id]))
  end
end
