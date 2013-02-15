class QuickController < ApplicationController


  def get_my_faculty_ids(group_name)
    if (group_name == "admin")
       department_ids = Department.find(:all).map {|d| d.id}
    elsif (group_name == "dean")
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
    
  def find_faculty_ids_by (search_by, search_id, group_name)
    if search_by == "all"
      faculty_ids = get_my_faculty_ids(group_name)
    elsif search_by == "school"
      faculty_ids = get_faculty_ids_by_school(search_id)
    else
      faculty_ids = get_faculty_ids_by_department(search_id) 
    end
    return faculty_ids
  end
  
    
  def criteria
    @task_name = params[:task_name]
    @ask_group = params[:ask_group].nil? ? true : params[:ask_group].to_boolean
    @ask_semester = params[:ask_semester].nil? ? true : params[:ask_semester].to_boolean
  end
  
  def dean_signoff
    session[:semester_id] = params[:semester_id] 
    @semester_id = params[:semester_id] 
    @search_by = params[:search_by]   
    @search_id = !params[:search_id].nil? ? params[:search_id] : (params[:search_by] == "department" ? params[:department_id] : params[:school_id])

    faculty_ids = find_faculty_ids_by(@search_by, @search_id, session[:group_name])    

    @results = Reason.where(:faculty_id => faculty_ids, :review_state => [Reason.review_pending, Reason.review_failed], :dean_signoff => false, )    
    @results.each_index do |i|
      # Restrict results to that faculty and semester
      @results[i] = nil if (!@results[i].course.is_taught_by(@results[i].faculty_id, @semester_id))
    end
    @results.compact!
  end
  
  def show_reason_details
    
  end
  
  def mark_signed_off
    # Ajax 
    # http://net.tutsplus.com/tutorials/javascript-ajax/using-unobtrusive-javascript-and-ajax-with-rails-3/
    # http://www.madebydna.com/all/code/2011/12/05/ajax-in-rails-3.html
    # Simple Popup: // http://stackoverflow.com/questions/5208412/how-to-use-the-link-to-helper-to-open-a-popup
    reason = Reason.find(params[:id])
    reason.update_attributes(:dean_signoff => true, :dean_id => current_user.id)    
    respond_to do |format|
      format.html
      format.js  
    end
  end
    
end
