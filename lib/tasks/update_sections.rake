require 'csv'

# "XITRACS_COURSE_SECTIONS.txt" => "COURSE_ID|SEMESTER|NAME|TITLE|DESCRIPTION",

desc 'Import CSV file into an Active Record table'

task :update_sections, [:filename, :update, :debug] => :environment do |task,args| # XXX
  total_inserts = 0
  total_updates = 0

  update_mode = args[:update] == 'update' ? true : false
  debug_mode = args[:debug] == 'debug' ? true : false

  total_rows = -1

  # get list of semester to speed up imports
  semester = {}
  Semester.all.each {|s| semester[s.name] = s.id}
  
  sections = Section.find(:all)  # XXX 
  CSV.foreach(args[:filename], {col_sep: '|', quote_char: '%'}) do |row|

    total_rows += 1
    next if (total_rows == 0)
    p row if debug_mode
    
    # XXX
    # row[10] = 'Unknown' if row[10] == nil
    # row[i] = 'Unknown Degree' if row[i] == nil
    
    # XXX
    params = {}
    params["course_id"] = ((d = Course.find_by_name(row[0])) != nil ? d.id : nil)
    params["semester_id"] = semester[row[1]]
    params["name"] = row[2]
    params["title"] = row[3]
    params["description"] = row[4]

    # XXX    
    if params["course_id"] == nil 
      puts "Unknown Course: #{row[0]}"
      next
    end
    if params["semester_id"] == nil
       puts "Unknown Semester: #{row[1]}"
       next
    end
    
    p params if debug_mode
        
    if ((section = Section.find_by_name(params["name"])) != nil) # XXX
      sections.delete(section)
      do_update = false
      section.attributes.keys.each do |key|
        next if ["id", "created_at", "updated_at", "completed", "description"].index(key)
        if section[key].to_s != params[key].to_s
          p "Match Failed for #{key} : #{section[key].to_s} and #{params[key].to_s}" if debug_mode
          section.update_attributes(params)
          puts("Update Record: #{params}")  if debug_mode
          total_updates += 1
          break
        end 
      end
    else
      Section.create(params) # XXX
      puts("Create Record: #{params}")  if debug_mode
      total_inserts += 1
    end
  end
  
  puts "Total Rows: #{total_rows}  Total Inserts: #{total_inserts}   Total Updates: #{total_updates}"
  puts "Records Deleted: #{sections.count}"
  
  sections.each do |section|
    sectionenrollments = Sectionenrollment.where(:section_id => section.id)
	 # These SE's will be deleted in update_sectionenrollments
    puts "Deleting Section #{section.name} (ID: #{section.id}). Orphaned #{sectionenrollments.count} Section Enrollments:" if sectionenrollments.count > 0
    if sectionenrollments.count > 0
      print "\tSection Enrollment IDs: "
      sectionenrollments.each do |se|
			print "[#{se.id}] "
      end 
      puts 
    end
    section.delete
  end
end
