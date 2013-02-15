desc 'Update all Faculty and Course status'

task :update_statuses, [:doall,:debug] => :environment do |task,args|
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
   
  debug_mode = args[:debug] == 'debug' 
  
  # Test just one faculty
  #faculties = Faculty.where(:znumber => 'Z23004818')
  
  faculties = Faculty.find(:all)
  total_faculty_updated = 0
  puts "Processing #{faculties.count} Faculty Members."
  faculties.each do |faculty|
    all_courses_done = false
    sectionenrollment_ids = Sectionenrollment.where(:faculty_id => faculty.id).map {|row| row.section_id}
    next if (sectionenrollment_ids.count == 0) # Faculty is not teaching anything
    puts "Processing #{sectionenrollment_ids.count} Sections for #{faculty.last_name}, #{faculty.first_name} (#{faculty.znumber})" if debug_mode
    if (args[:doall] == 'rebuild') 
      sectionenrollments_completed = Sectionenrollment.where(:faculty_id => faculty.id, :completed => true)
      sectionenrollments_completed.each do |se|
        puts "Processing sectionenrollment: id: #{se.id} section_id: #{se.section_id}" if debug_mode
        puts "Processing section: id: #{se.section.id} name: #{se.section.name}" if debug_mode
        t_sections = Section.where(:course_id => se.section.course.id).map  {|row| row.id}
        t_section_enrollments = Sectionenrollment.where(:section_id => t_sections, :faculty_id => faculty.id, :completed => false)
        next if (t_section_enrollments.count == 0)
        puts "Updating #{se.section.course.name} for #{faculty.last_name}, #{faculty.first_name} \t (#{faculty.znumber}) : #{t_section_enrollments.count.to_s} records" if debug_mode 
        t_section_enrollments.each do |s|
          #puts "Faculty: #{faculty.znumber}: Semester: #{s.section.semester.name} " # if s.section.semester.name != 'Fall 2011'
          s.update_attributes(:completed => true)
        end
        total_faculty_updated += 1
      end
    elsif  (args[:doall] == 'rebuildall') 
      # Rebuild full information based on all reasons+credits. Can be errors due to +18credits
      course_ids = Section.where(:id => sectionenrollment_ids).group(:course_id).map {|row| row.course_id}
      puts "XXX: No Courses found for #{faculty.znumber}" if course_ids.count == 0
      total_courses_completed = 0
      courses = Course.where(:id => course_ids)
      courses.each do |course|
        reasons = Reason.where(:faculty_id => faculty.id, :course_id => course.id)
        next if reasons.count == 0 # Has not yet been credentialed
        if reasons.count > 1
          puts "XXX: Multiple Reasons #{reasons.count} found for #{faculty.znumber} teaching #{course.name}"
          break
        end
        reason = reasons.first # Should only be one record so just take that record
        puts "Course #{course.name} Reason: #{reason.qualificationreason.name}" if debug_mode
        if ([@QR_OTHER_COURSES, @QR_OTHER_COURSES_AND_COMMENTS, @QR_MASTERS, @QR_BACHELORS].index(reason.qualificationreason_id) != nil)
          total_credits=0.0
          Credit.where(:faculty_id => faculty.id).map do |credit| 
            if credit.semester_credits
              total_credits = total_credits + credit.course_credits.to_f
            else 
             total_credits = total_credits + (credit.course_credits.to_f * 2.0) / 3.0 # Convert quarter to semester 
            end
          end
          puts "Course #{course.name} Total Credits: #{total_credits}"  if debug_mode
          course_justification_completed = total_credits >= 18       
        elsif ([@QR_EXCEPTION].index(reason.qualificationreason_id) != nil)
          course_justification_completed = false # Exception reason will always make a course not-completed status
        else
          course_justification_completed = true
        end
        total_courses_completed +=1 if course_justification_completed
        # Update the sections of that course for that professor to reflect if they are/are-not completed
        t_sections = Section.where(:course_id => course.id).map  {|row| row.id}
        t_section_enrollments = Sectionenrollment.where(:section_id => t_sections, :faculty_id => faculty.id)
        t_section_enrollments.each {|s| s.update_attributes(:completed => course_justification_completed)}           
      end # Course.where.each
      puts "#{faculty.znumber} : Total Courses: #{courses.count} Completed: #{total_courses_completed}"  if debug_mode
      all_courses_done = total_courses_completed == courses.count
    end
  end # faculties.each
  puts "\nTotal Faculty Updated: #{total_faculty_updated}"
end

