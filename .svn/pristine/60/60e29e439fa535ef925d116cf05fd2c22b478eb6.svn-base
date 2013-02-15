require 'csv'
class ReportController < ApplicationController
  
  def get_my_faculty_ids
    if (session[:group_name] == "admin")
       department_ids = Department.find(:all).map {|d| d.id}
    elsif (session[:group_name] == "dean")
       department_ids = Department.where(:school_id => current_user.school_id).map {|d| d.id}
    else
      department_ids = [current_user.department_id]
    end
    faculty_ids = Faculty.where(:department_id => department_ids).map {|f| f.id}
    return faculty_ids
  end
  
  def get_faculty_ids_by_school (school_id)
    department_ids = Department.where(:school_id => school_id).map {|d| d.id}
    faculty_ids = Faculty.where(:department_id => department_ids).map {|f| f.id}
    return faculty_ids
  end
  
  def get_faculty_ids_by_department (department_id)
    faculty_ids = Faculty.where(:department_id => department_id).map {|f| f.id}
    return faculty_ids
  end
    
  def find_faculty_ids_by (search_by, search_id)
    if search_by == "all"
      faculty_ids = get_my_faculty_ids
    elsif search_by == "school"
      faculty_ids = get_faculty_ids_by_school(search_id)
    else
      faculty_ids = get_faculty_ids_by_department(search_id) 
    end
    return faculty_ids
  end
  
  
  def users
    @users = User.order(:group_id)
  end
  
  def report_criteria
    @report_name = params[:report_name]
    @ask_semester = params[:ask_semester].nil? ? true : params[:ask_semester].to_boolean
    @ask_group = params[:ask_group].nil? ? true : params[:ask_group].to_boolean
    @ask_review_reasons = !params[:ask_review_reasons].nil?
    @ask_qualificationreasons = !params[:ask_qualificationreasons].nil?
    @ask_deansignoff = !params[:ask_deansignoff].nil?
    @ask_reviewstate = !params[:ask_reviewstate].nil?
    @ask_faculty_or_course = params[:ask_faculty_or_course].nil? ? false : params[:ask_faculty_or_course].to_boolean
  end
  
  def send_reasons(results, filename)
    data = CSV.generate do |csv|
      csv << ["Last Name", "First Name", "Department (College)", "Z Number", "Course ID", "Course Title","Review Reasons","Review Comments"] 
      results.each do |r|
        csv << [r.faculty.last_name,r.faculty.first_name,r.faculty.department.name_and_school,r.faculty.znumber,r.course.name,r.course.title,r.reviewreasons.map{|rr| rr.name}.join("; "), r.review_comments]
      end
    end
    send_data data,  :type => 'text/csv; charset=iso-8859-1; header=present',
                    :disposition => "attachment; filename=#{filename}"  
  end
  
  def summary
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id]   
  end
  
  def course_and_faculty_summary
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id]     
    
    sections = Section.where(:semester_id =>  @semester_id)
    course_list_done = {}
    courses_list_notdone = {}
    @reason_list_notdone = {}
    faculty_list_done = {}
    faculty_list_notdone = {}
    @sections_done = 0
    @sections_notdone = 0
    sections.each do |section|
      se = Sectionenrollment.where(:section_id => section.id).first
      reason = Reason.where(:course_id => section.course_id, :faculty_id => se.faculty_id).first
      if (!reason.nil? && reason.review_state == Reason.review_passed)
        @sections_done += 1
        course_list_done[section.course_id] = course_list_done[section.course_id].nil? ? 1 : course_list_done[section.course_id] + 1
        faculty_list_done[se.faculty_id] = faculty_list_done[se.faculty_id].nil? ? 1 : faculty_list_done[se.faculty_id] + 1
      else
        @sections_notdone += 1
        courses_list_notdone[section.course_id] = courses_list_notdone[section.course_id].nil? ? 1 : courses_list_notdone[section.course_id] + 1
        faculty_list_notdone[se.faculty_id] = faculty_list_notdone[se.faculty_id].nil? ? 1 : faculty_list_notdone[se.faculty_id] + 1        
      end
      if (!reason.nil?)
        @reason_list_notdone[reason.review_state] = @reason_list_notdone[reason.review_state].nil? ? 1 : @reason_list_notdone[reason.review_state] + 1
      end       
    end
    @courses_done = course_list_done.count  
    @courses_notdone = courses_list_notdone.count    

    faculty_list_notdone.keys.each do |faculty_id|
      faculty_list_done.delete(faculty_id)  
    end
    @faculty_done = faculty_list_done.count
    @faculty_notdone = faculty_list_notdone.count
  end
  
  def report_reviewstate
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id] 
    @search_by = params[:search_by]   
    @search_id = !params[:search_id].nil? ? params[:search_id] : (params[:search_by] == "department" ? params[:department_id] : params[:school_id]) 
    @reviewstate = params[:review_state]
    
    faculty_ids = find_faculty_ids_by(@search_by, @search_id)    
    @results = Reason.where(:review_state => @reviewstate, :faculty_id => faculty_ids)
    # Remove any reasons if this course is not taught by this faculty in this semester    
    @results.each_index do |i|
      reason = @results[i]
      section_ids = Section.where(:course_id => reason.course_id, :semester_id => @semester_id).map {|section| section.id}
      sectionenrollments = Sectionenrollment.where(:section_id => section_ids, :faculty_id => reason.faculty_id)
      @results[i] = nil if sectionenrollments.count == 0
    end
    @results.compact!
  end
  
  def report_not_passed   
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id] 
    @search_by = params[:search_by]   
    @search_id = !params[:search_id].nil? ? params[:search_id] : (params[:search_by] == "department" ? params[:department_id] : params[:school_id])
    @reviewreason_ids = params[:reviewreason_ids]
    @reviewstate = params[:review_state]
    @dean_signoff = params[:dean_signoff] == "true"

    faculty_ids = find_faculty_ids_by(@search_by, @search_id)    

    @results = Reason.where(:review_state => @reviewstate, :faculty_id => faculty_ids, :dean_signoff => @dean_signoff )    
    @results.each_index do |i|
      # Restrict results to the subset of reasons
      if !@reviewreason_ids.nil? && @reviewreason_ids.count > 0  
        @results[i] = nil if (@results[i].reviewreasons.where(:id => @reviewreason_ids).count == 0)
      end
      # Restrict results to that faculty and semester
      if !@results[i].nil?
        @results[i] = nil if (!@results[i].course.is_taught_by(@results[i].faculty_id, @semester_id))
      end
    end
    @results.compact!
   
    if (params[:csv])
      send_reasons(@results, "results_not_passed.csv")
    end    
  end
  
  def report_not_passed_and_not_deansignoff
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id]     
    @search_by = params[:search_by]   
    @search_id = !params[:search_id].nil? ? params[:search_id] : (params[:search_by] == "department" ? params[:department_id] : params[:school_id])

    faculty_ids = find_faculty_ids_by(@search_by, @search_id)    
 
    @results = Reason.where(:review_state => Reason.review_failed, :dean_signoff => false, :faculty_id => faculty_ids)
    @results.each_index do |i|
      @results[i] = nil if (!@results[i].course.is_taught_by(@results[i].faculty_id, @semester_id))
    end
    @results.compact!
   
    if (params[:csv])
      send_reasons(@results, "results_not_passed_and_not_deansignoff.csv")
    end    
  end

  def report_credentialing
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id]     
    @search_by = params[:search_by]   
    @semester_name = Semester.find(@semester_id).name
    @search_id = !params[:search_id].nil? ? params[:search_id] : (params[:search_by] == "department" ? params[:department_id] : params[:school_id])
    @qualificationreason_ids = params[:qualificationreason_ids]

    @results = []

    if @qualificationreason_ids.nil? || @qualificationreason_ids.count == 0
      flash[:notice] = "No Qualification Reason provided"
      return
    end
      
    faculty_ids = find_faculty_ids_by(@search_by, @search_id)    
    donesemesters = Donesemester.where(:faculty_id => faculty_ids, :semester_id => @semester_id)
    donesemesters.each do |ds|
      reasons = Reason.where(:faculty_id => ds.faculty_id, :qualificationreason_id => @qualificationreason_ids)
      reasons.each do |r|
        section_ids = Section.where(:course_id => r.course_id, :semester_id => @semester_id).map {|section| section.id}
        sectionenrollments = Sectionenrollment.where(:section_id => section_ids, :faculty_id => ds.faculty_id) 
        sectionenrollments.each do |se|
          @results.push(r)   # XXX - should this be 'se' 
        end
      end
    end
    
    if (params[:csv])
      data = CSV.generate do |csv|
  
        csv << [  "Last Name", "First Name", "Department (College)", "Z Number", 
                  "Degree", "Qualification Reason", "Course ID", "Semester"] 
        @results.each do |r|
          csv << [  r.faculty.last_name,r.faculty.first_name,r.faculty.department.name_and_school,r.faculty.znumber,
                    r.faculty.qualification.name,r.qualificationreason.name,r.course.name,@semester_name]
        end
      end
      send_data data,  :type => 'text/csv; charset=iso-8859-1; header=present',
                      :disposition => "attachment; filename=results_report_credentialing.csv"  
    end
  end
  
  def report_credentialing_not_completed
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id]     
    @search_by = params[:search_by]   
    @semester_name = Semester.find(@semester_id).name
    @search_id = !params[:search_id].nil? ? params[:search_id] : (params[:search_by] == "department" ? params[:department_id] : params[:school_id])
 
    @results = []

    faculty_ids = find_faculty_ids_by(@search_by, @search_id)    
    donesemesters = Donesemester.where(:faculty_id => faculty_ids, :semester_id => @semester_id, :completed => false)
    donesemesters.each do |ds|
      section_ids = Sectionenrollment.where(:faculty_id => ds.faculty_id, :completed => false).map {|se| se.section_id}      
      Section.where(:id => section_ids, :semester_id => @semester_id).each do |section|
          @results.push([ds.faculty, section])          
      end
    end
    if (params[:csv])
      data = CSV.generate do |csv|
  
        csv << [  "Last Name", "First Name", "Department (College)", "Z Number", 
                  "Degree", "Course ID", "Semester"] 
        @results.each do |faculty,section|
          csv << [  faculty.last_name,faculty.first_name,faculty.department.name_and_school,faculty.znumber,
                    faculty.qualification.name,section.course.name,@semester_name]
        end
      end
      send_data data,  :type => 'text/csv; charset=iso-8859-1; header=present',
                      :disposition => "attachment; filename=results_report_credentialing_not_completed.csv"  
    end

  end
  
    
  def search_by_credit_course
    @results = nil    
    faculty_list = get_my_faculty_ids.map {|f| f.to_s}.join(",")

    if (params[:keyword])
      query = "select c.course_name 'course_name', c.course_description 'course_description', f.last_name 'last_name', f.first_name 'first_name', f.znumber 'znumber' 
                from credits c, faculties f 
                where c.faculty_id=f.id 
                and f.id in (#{faculty_list})
                and course_name like '%#{params[:keyword]}%' 
                group by faculty_id"
      @results = ActiveRecord::Base.connection.select_all(query)
      @keyword = params[:keyword]
    end  

    if (params[:csv]) 
      data = CSV.generate do |csv|
        csv << ["Course Name", "Course Description", "Last Name", "First Name", "Znumber"] 
        @results.each do |row|
          csv << row.values.to_a
        end
      end
      send_data data,  :type => 'text/csv; charset=iso-8859-1; header=present',
                      :disposition => "attachment; filename='results_#{params[:keyword]}.csv'"          
    end
  end  
  

  def report_faculty_course
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id]     
    @search_by = params[:search_by]   
    @search_id = !params[:search_id].nil? ? params[:search_id] : (params[:search_by] == "department" ? params[:department_id] : params[:school_id])

    faculty_ids = find_faculty_ids_by(@search_by, @search_id)    
 
    if (params[:faculty_or_course] == "faculty") 
      # Get a List of faculty and the courses they are credentialed to teach
      @results = Reason.where(:review_state => Reason.review_passed, :faculty_id => faculty_ids).order(:faculty_id)
    else
      # Get a List of Courses and the faculty who are credentialed to teach those courses
      @results = Reason.where(:review_state => Reason.review_passed, :faculty_id => faculty_ids).order(:course_id)
    end
            
    if (params[:csv])
      data = CSV.generate do |csv|
        csv << ["Last Name", "First Name", "Znumber", "Department(College)", "Course Name", "Course Title"] 
        @results.each do |r|
          csv << [ r.faculty.last_name,r.faculty.first_name,r.faculty.znumber,r.faculty.department.name_and_school,r.course.name,r.course.title]       
        end
      end
      send_data data,  :type => 'text/csv; charset=iso-8859-1; header=present',
                      :disposition => "attachment; filename='results_faculty_course.csv'"          
    end        
  end
end
