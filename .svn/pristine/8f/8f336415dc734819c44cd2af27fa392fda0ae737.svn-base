require 'csv'

# "ZNUMBER|EMAIL|FIRST_NAME|MIDDLE_NAME|LAST_NAME|TITLE_ID|DEPARTMENT_ID|RANK_ID|EMPLOYMENTSTATUS_ID|TENURESTATUS_ID|QUALIFICATION_ID|CV_ONFILE"

desc 'Import CSV file into an Active Record table'

task :update_faculty, [:filename, :update, :debug] => :environment do |task,args|
  total_inserts = 0
  total_updates = 0

  update_mode = args[:update] == 'update' ? true : false
  debug_mode = args[:debug] == 'debug' ? true : false

  total_rows = -1

  all_records = Faculty.find(:all) 
  CSV.foreach(args[:filename], {col_sep: '|', quote_char: '%'}) do |row|

    total_rows += 1
    next if (total_rows == 0)
    p row if debug_mode
    
    row[10] = 'Unknown' if row[10] == nil
    # row[i] = 'Unknown Degree' if row[i] == nil
    
    params = {}
    params["znumber"] = row[0]
    params["email"]   = row[1]
    params["first_name"] = row[2]
    params["middle_name"] = row[3]
    params["last_name"] = row[4]
    params["title_id"] = Title.find_by_name(row[5]).id
    department_name = row[6].sub("Honor's", "Honors") # Strip out the apostrophe from the department name
    params["department_id"] = Department.find_by_name(department_name).id 
    params["rank_id"] = Rank.find_by_name(row[7]).id
    params["employmentstatus_id"] = Employmentstatus.find_by_name(row[8]).id
    params["tenurestatus_id"] = Tenurestatus.find_by_name(row[9]).id
    params["qualification_id"] = Qualification.find_by_name(row[10]).id
    params["cv_onfile"] = row[11]


    p params if debug_mode
        
    if ((record = Faculty.find_by_znumber(params["znumber"])) != nil) 
      all_records.delete(record)
      do_update = false
      update_attributes = {}
      record.attributes.keys.each do |key|
        next if ["id", "created_at", "updated_at", "completed"].index(key)
        if record[key].to_s != params[key].to_s
          p "Match Failed for #{key} : #{record[key].to_s} and #{params[key].to_s}" if debug_mode
          update_attributes[key] = params[key]
          #record.update_attributes(params)
          #puts ("Update Record: #{params}")  if update_mode
          total_updates += 1
          #break
        end 
      end
      if update_attributes.count > 0
        record.update_attributes(update_attributes)
        puts "Update Record: #{record.znumber} #{record.last_name} : #{update_attributes}"  if debug_mode
      end
    else
      Faculty.create(params)
      puts "Create Record: #{params}"  if debug_mode
      total_inserts += 1
    end
  end
  
  puts "Total Rows: #{total_rows}  Total Inserts: #{total_inserts}   Total Updates: #{total_updates}"
  puts "Records To Be Deleted: #{all_records.count}" if all_records.count > 0 
  all_records.each do |record|
    #puts "Deleting: #{record.to_json}"
    r = Reason.where(:faculty_id => record.id)
    c = Credit.where(:faculty_id => record.id)
    se = Sectionenrollment.where(:faculty_id => record.id)
    fc = Facultycredential.where(:faculty_id => record.id)
    ds = Donesemester.where(:faculty_id => record.id)
    if (r.count > 0 || c.count > 0 || fc.count > 0)
      print "\tDeleting #{record.znumber} (#{record.last_name}, #{record.first_name}) has orphaned : "
      print "[#{se.count} Section Enrollments] " if (se.count > 0)
      print "[#{fc.count} Faculty Credentials] " if (fc.count > 0)
      print "[#{r.count} Reasons (deleted)] " if (r.count > 0)
      print "[#{c.count} Credits (deleted)] " if (c.count > 0)
      print "[#{ds.count} Done Semesters (deleted)] " if (ds.count > 0)
      puts "\n" 
    end
    #r.delete if r = Reason.find_by_faculty_id(record.id)
    #c.delete if c = Credit.find_by_faculty_id(record.id)
    record.delete
    r.each {|row| row.delete}
    c.each {|row| row.delete}
    ds.each {|row| row.delete}    
  end
end