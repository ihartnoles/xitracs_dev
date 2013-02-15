require 'csv'

# ""NAME|TITLE|DESCRIPTION|DEPARTMENT_ID|LEVEL_DESCRIPTION|CREDIT|RULES|CIP_CODES"
# ""NAME|TITLE|DESCRIPTION|DEPARTMENT_ID|LEVEL_DESCRIPTION|CREDIT|RULES|STATUS|CIP_CODES"


desc 'Import CSV file into an Active Record table'

task :update_courses, [:filename, :onlycreate, :update, :debug] => :environment do |task,args|
  total_inserts = 0
  total_updates = 0

  only_create = args[:onlycreate] == 'onlycreate'
  update_mode = args[:update] == 'update'
  debug_mode = args[:debug] == 'debug'

  total_rows = -1

  all_records = Course.find(:all)  # XXX 
  CSV.foreach(args[:filename], {col_sep: '|', quote_char: '%'}) do |row|

    total_rows += 1
    next if (total_rows == 0)
    p row if debug_mode
    
    # XXX
    # row[10] = 'Unknown' if row[10] == nil
    # row[i] = 'Unknown Degree' if row[i] == nil
    
    # XXX
    params = {}
    params["name"] = row[0]
    params["title"]   = row[1]
    params["description"] = row[2]
    department_name = row[3].sub("Honor's", "Honors") # Strip out the apostrophe from the department name
    params["department_id"] = ((d = Department.find_by_name(department_name)) != nil ? d.id : nil)
    params["level_description"] = row[4]
    params["credit"] = row[5]
    params["rules"] = row[6]
    #params["status"] = row[7]
    params["cip_codes"] = row[8]
    
    if params["department_id"] == nil 
      puts "Unknown Department: '#{row[3]}' for course '#{row[0]}'"
      next
    end

    p params if debug_mode
        
    if ((record = Course.find_by_name(params["name"])) != nil) # XXX
      all_records.delete(record)
      next if (only_create) # Skip updates if requested (i.e the current records are already the latest. For importing older semester courses)
      record.attributes.keys.each do |key|
        next if ["id", "created_at", "updated_at", "completed", "description"].index(key)
        if record[key].to_s != params[key].to_s
          p "Match Failed for #{key} : #{record[key].to_s} and #{params[key].to_s}" if debug_mode
          record.update_attributes(params)
          params["description"] = "" # Remove for cleaner printing
          params["rules"] = "" # Remove for cleaner printing
          puts("Update Record (#{key}): #{params}")  if debug_mode
          total_updates += 1
          break
        end 
      end
    else
      Course.create(params) # XXX
      params["description"] = "" # Remove for cleaner printing
      params["rules"] = "" # Remove for cleaner printing
      puts("Create Record: #{params}")  if debug_mode
      total_inserts += 1
    end
  end
  
  puts "Total Rows: #{total_rows}  Total Inserts: #{total_inserts}   Total Updates: #{total_updates}"
  puts "Records Deleted: #{all_records.count}"
  all_records.each do |record|
    #puts "Deleting: #{record.name}"
    reasons = Reason.where(:course_id => record.id)
    if (reasons.count > 0)
      puts "XXX Deleting Course #{record.name} will Orphan #{reasons.count} Reasons."
    end
    sections = Section.where(:course_id => record.id)
    if (sections.count > 0)
      puts "XXX Deleting Course #{record.name} will Orphan #{sections.count} Sections."
      sections.each do |section|
        sectionenrollments = Sectionenrollment.where(:section_id => section.id)
        puts "XXX Deleting Course #{record.name} will Orphan #{sectionenrollments.count} Section Enrollments." if sectionenrollments.count > 0
      end
    end
    # XXX
    #r.delete if r = Reason.find_by_faculty_id(record.id)
    #c.delete if c = Credit.find_by_faculty_id(record.id)
    record.delete
  end
end