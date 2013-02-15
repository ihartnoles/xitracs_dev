require 'csv'

# "XITRACS_COURSE_SECTION_ENROLLMENTS.txt" => "SECTION_ID|FACULTY_ID|EMAIL|SECTION_ROLE",

desc 'Import CSV file into an Active Record table'

task :update_sectionenrollments, [:filename, :update, :debug] => :environment do |task,args| # XXX
  total_inserts = 0
  total_updates = 0

  update_mode = args[:update] == 'update' ? true : false
  debug_mode = args[:debug] == 'debug' ? true : false

  total_rows = -1
  unknown_section = 0
  unknown_faculty = 0
  all_sectionenrollments = Sectionenrollment.find(:all)  # XXX 
  CSV.foreach(args[:filename], {col_sep: '|', quote_char: '%'}) do |row|

    total_rows += 1
    next if (total_rows == 0)
    p row if debug_mode
    
    # XXX
    # row[10] = 'Unknown' if row[10] == nil
    # row[i] = 'Unknown Degree' if row[i] == nil
    
    # XXX
    params = {}
    params["section_id"] = ((d = Section.find_by_name(row[0])) != nil ? d.id : nil)
    params["faculty_id"] = ((d = Faculty.find_by_znumber(row[1])) != nil ? d.id : nil)
    params["email"] = row[2]
    params["section_role"] = row[3]

    # XXX    
    if params["section_id"] == nil 
      puts "Unknown Section: #{row[0]} #{row[1]} #{row[2]} #{row[3]}"
      unknown_section += 1
      next
    end
    if params["faculty_id"] == nil 
      puts "Unknown Faculty #{row[0]} #{row[1]} #{row[2]} #{row[3]}"
      unknown_faculty += 1
      next
    end
    p params if debug_mode
        
    if ((sectionenrollment = Sectionenrollment.where(:section_id => params["section_id"], :faculty_id => params["faculty_id"]).first) != nil) # XXX
      all_sectionenrollments.delete(sectionenrollment)
      do_update = false
      sectionenrollment.attributes.keys.each do |key|
        next if ["id", "created_at", "updated_at", "completed", "description"].index(key)
        if sectionenrollment[key].to_s != params[key].to_s
          p "Match Failed for #{key} : #{sectionenrollment[key].to_s} and #{params[key].to_s}" if debug_mode
          sectionenrollment.update_attributes(params)
          params["description"] = "" # Remove for cleaner printing
          puts("Update Record: #{params}")  if debug_mode
          total_updates += 1
          break
        end 
      end
    else
      Sectionenrollment.create(params) # XXX
      puts("Create Record: #{params}")  if debug_mode
      total_inserts += 1
    end
  end
  
  puts "Total Rows: #{total_rows}  Total Inserts: #{total_inserts}   Total Updates: #{total_updates}"
  puts "Unknown Sections: #{unknown_section}  Unknown Faculty #{unknown_faculty}"
  puts "Records Deleted: #{all_sectionenrollments.count}"
  
  all_sectionenrollments.each do |se|
    puts "Deleting ID: #{se.id}" if debug_mode
	 # XXX - Not deleting reasons or credits in case we need this in the future
    #sectionenrollments = Sectionenrollment.where(:section_id => record.id)
    #puts "XXX Deleting Section #{record.name} will Orphan #{sectionenrollments.count} Section Enrollments." if sectionenrollments.count > 0
    #r.delete if r = Reason.find_by_faculty_id(record.id)
    #c.delete if c = Credit.find_by_faculty_id(record.id)
    se.delete
  end
end
