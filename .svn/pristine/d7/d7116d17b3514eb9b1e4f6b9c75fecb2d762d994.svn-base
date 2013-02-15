
desc "Adding Semester Information for Sections"

task :update_semesters, [:what, :debug] => :environment do |task,args|  
  
  debug_mode = args[:debug] == 'debug' ? true : false

  if (args[:what] != 'move')
    puts "Updating Faculty 'Done Semesters'"
    done = Donesemester.where(:completed => true).count
    not_done = Donesemester.where(:completed => false).count
    puts "Before Update: Completed: #{done} Not Completed: #{not_done}"
    
    Faculty.find(:all).each do |faculty|
      Donesemester.freshen_all(faculty)
    end
    
    done = Donesemester.where(:completed => true).count
    not_done = Donesemester.where(:completed => false).count
    puts "After Update: Completed: #{done} Not Completed: #{not_done}"
    
    # XXX : Need to remove records in donesemesters for faculty who no longer exist
  else
    # 'move' = cleanup for old data. No longer used. 
    puts "Adding Semester Information for Sections"
    total_updates = 0
    semester = {}
    Semester.find(:all).each {|s| semester[s.prefix] = s.id}
    puts "Semesters: #{semester}" if debug_mode
    
    Section.where(:semester_id => nil).each do |section|
      if (semester[section.name.split('-').first] != nil)
        section.semester_id = semester[section.name.split('-').first]
        section.save
        total_updates += 1
      else
        puts "XXX: Error - Unable to find Semester #{section.name.split('-').first}"
      end
    end
    puts "Total Section Semesters Updated: #{total_updates}"
  end        
end