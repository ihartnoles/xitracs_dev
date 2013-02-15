
desc "Sanity Check"

def print_fc(params)
  puts "\t#{params.id} : #{params.qualificationaward.name} - #{params.qualification_name} - #{params.qualification_institution} - #{params.qualification_field} - #{params.qualification_year}"        
end

def ask message
  print message
  STDIN.gets.chomp
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
  
  
def remove_unlinked_reasons
  # Remove reasons for courses no longer taught by someone
end

def fix_completed_status
#  reasons = Reason.where(:qualificationreason_id => @QR_EXCEPTION)
#  reasons.each do |reason|
#    section_ids = reason.course.sections.map {|s| s.id}
#    sectionenrollments = Sectionenrollment.where(:faculty_id => reason.faculty_id, :section_id => section_ids)
#  end
end

def fix_facultycredential(credit_id)
  credit = Credit.find(credit_id)
  return if credit.nil?
  
  facultycredentials = Facultycredential.where(:faculty_id => credit.faculty_id)
  if facultycredentials.count > 0      
    puts "Fixing Course Credit - Name: #{credit.course_name} Desc: #{credit.course_description} Year: #{credit.course_year} for #{credit.faculty.znumber}"
    facultycredentials.each {|fc| print_fc(fc)}  
    
    if (facultycredentials.size == 1)
      credit.update_attributes(:facultycredential_id => facultycredentials[0].id)
      puts "\tAuto-update to #{facultycredentials[0].id}"
    elsif ((id = (ask "\tWhich ID should be used?: ")) != "")
      credit.update_attributes(:facultycredential_id => id.to_i )
    end
  else   
    if (credit.faculty.nil?)
      puts "Missing Faculty for Credit ID: #{credit.id}."
      if (ask("Delete (yes/no)? ") == "yes")
        credit.delete
      end
    else
      puts "No Credentials : #{credit.faculty.details}"
      credit.faculty.print_courses
      puts
    end      
  end
end

# Check for any credits that don't have a valid faculty credential

def check_faculty_course_credit(debug)  
  credit_facultycredential_ids = Credit.find(:all).map {|credit| [credit.id, credit.facultycredential_id]}
  facultycredential_ids = Facultycredential.find(:all).map {|fc| fc.id}

  # Credits that have an Invalid FC 
  facultycredential_missing_ids = []  
  credit_facultycredential_ids.each do |credit_id, fc_id| 
    facultycredential_missing_ids.push(credit_id) if fc_id.nil? || facultycredential_ids.index(fc_id).nil?
  end    
  
  if facultycredential_missing_ids.count > 0
    puts "There are #{facultycredential_missing_ids.count} Course Credits that have Invalid/NIL facultycredential_id\n"
    facultycredential_missing_ids.each do |credit_id|
      fix_facultycredential(credit_id)
    end
  end
end

# Check for orphaned reasons

task :sanity_check, [:debug] => :environment do |task,args|  
  puts "Sanity Check of Data"
  
  debug = args[:debug] == 'debug' ? true : false

  puts "Faculty Credential Check:"
  check_faculty_course_credit(debug)
  #check_orphaned_reasons(debug)      
end