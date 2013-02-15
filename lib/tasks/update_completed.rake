
desc "Adding Semester Information for Sections"

task :update_completed, [:debug] => :environment do |task,args|  
  puts "Adding Semester Information for Sections"
  
  debug_mode = args[:debug] == 'debug' ? true : false

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
  puts "Total Updated: #{total_updates}"
end