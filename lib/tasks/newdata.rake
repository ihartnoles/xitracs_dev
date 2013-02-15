# http://erikonrails.snowedin.net/?p=212

require 'csv'


header_list = {
"XITRACS_SCHOOLS.txt"  => "NAME|DESCRIPTION", 
"XITRACS_DEPARTMENTS.txt" => "NAME|DESCRIPTION|SCHOOL_ID",
"XITRACS_QUALIFICATIONS_TYPE.txt" =>  "NAME|LEVEL",
"XITRACS_QUALIFICATIONS_AWARD.txt" =>  "QUALIFICATION_ID|NAME",
"XITRACS_COURSES.txt " =>  "NAME|TITLE|DESCRIPTION|DEPARTMENT_ID|LEVEL_DESCRIPTION|CREDIT|RULES|CIP_CODES"
#"XITRACS_FACULTY_MEMBERS.txt" => "ZNUMBER|EMAIL|FIRST_NAME|MIDDLE_NAME|LAST_NAME|TITLE_ID|DEPARTMENT_ID|RANK_ID|EMPLOYMENTSTATUS_ID|TENURESTATUS_ID|QUALIFICATION_ID|CV_ONFILE"
#"XITRACS_COURSE_SECTIONS.txt" => "COURSE_ID|SEMESTER|NAME|TITLE|DESCRIPTION",
#"XITRACS_COURSE_SECTION_ENROLLMENTS.txt" => "SECTION_ID|FACULTY_ID|EMAIL|SECTION_ROLE",
#"XITRACS_FACULTY_CREDENTIALS.txt" => "FACULTY_ID|EMAIL|QUALIFICATIONAWARD_ID|QUALIFICATION_NAME|QUALIFICATION_INSTITUTION|QUALIFICATION_FIELD|QUALIFICATION_YEAR|TRANSCRIPT_ON_FILE|CIP_CODES",
#"XITRACS_COURSE_SECTION_CREDENTIALS.txt" => "FACULTY_ID|EMAIL|QUALIFICATIONAWARD_ID|QUALIFICATION_NAME|QUALIFICATION_INSTITUTION|QUALIFICATION_YEAR|SECTION_ID"
}


desc 'Import CSV file into an Active Record table'

task :csv_model_update, [:filename, :model, :debug] => :environment do |task,args|
  firstline=0
  total_inserts = 0
  total_updates = 0
   
  table_list = {
    "school"              => ["School",         "name"],
    "department"          => ["Department",     "name"],
    "course"              => ["Course",         "name"],
    "section"             => ["Section",        "name"],
    "faculty"             => ["Faculty",        "znumber"],
    "qualification"       => ["Qualification",  "name"],
    "qualificationaward"  => ["Qualificationaward", "name"]
  }

  debug_mode = args[:debug] == 'debug' ? true : false
              

  p "Parsing : #{args[:filename]}" if debug_mode
  
  keys = CSV.parse(header_list[File.basename(args[:filename])], {col_sep: '|', quote_char: '%'})[0]
      
   
  puts "Header: #{keys}" if debug_mode
   
  p table_list if debug_mode
   
  total_rows = -1
 
  CSV.foreach(args[:filename], {col_sep: '|', quote_char: '%'}) do |row|

    total_rows += 1
    next if (total_rows == 0)
    p row if debug_mode

    params = {}
    skip_record = false

    keys.each_with_index do |key,i|
		  if (key.downcase.end_with?("_id")) then
        key_name = key.downcase.sub("_id","") # remove the "_id" 
        p "key = #{key} key_name = #{key_name}" if debug_mode
        
        # If the column references another table, then find the value from that table
        # Otherwise see if the record already exists.
        if (table_list[key_name] != nil) then
          p "Searching for #{table_list[key_name]} = #{row[i]}" if debug_mode
          row[i] = 'Unknown' if (key_name == 'qualification' && row[i] == nil) 
          row[i] = 'Unknown Degree' if (key_name == 'qualification_awardname' && row[i] == nil) 
          result = Module.const_get(table_list[key_name][0]).where(table_list[key_name][1] => row[i])
          if (result.count == 0) then    
            p "XXX : Unable to find record in [#{key_name}] for value [#{row[i]}] row =#{row}"    
            skip_record=true     
            break
          else
            p "Found record : #{result[0].id}" if debug_mode
            params[key.downcase] = result[0].id
          end
        else
           p "Searching for value = [#{row[i]}] in [#{key_name.capitalize}]" if debug_mode
           result = Module.const_get(key_name.capitalize).where("name" => row[i])
           if (result.count == 0 ) then
              p "Creating record in #{key_name.capitalize} for value [#{row[i]}]"  if debug_mode
              Module.const_get(key_name.capitalize).create("name" => row[i])
              if (result.count == 0) then
                p row
                p "XXX : Unable to create record in #{key_name} for value [#{row[i]}]" 
                skip_record = true
                break
              end
           else
              p "Found Record" if debug_mode
           end
           params[key.downcase] = result[0].id
        end
      else
        p "Adding Column : #{key.downcase} = #{row[i]}" if debug_mode
        params[key.downcase] = row[i]
      end
    end
    
    easy_models = ["School", "Department", "Course",  "Qualification", "Qualificationaward"]
   
   
    if (!skip_record) then
      p params if debug_mode
      if (easy_models.index(args[:model]) != nil)
        if (args[:model] == "Faculty")
          result = Module.const_get(args[:model]).find_by_znumber(params["znumber"])
        else
          result = Module.const_get(args[:model]).find_by_name(params["name"])
        end
        if (result != nil) 
          puts "Found Existing Record: #{result.to_json}" if debug_mode
          skip_update = true
          result.attributes.keys.each do |key|
            next if ["id", "created_at", "updated_at", "enabled", "completed"].index(key)
            p "Comparing [#{result[key]}] with [#{params[key]}]" if debug_mode
            if result[key].to_s != params[key].to_s
              p "Comparison Failed: [#{result[key]}] with [#{params[key]}]"
              skip_update = false 
            end
          end
          puts "Skipping? #{skip_update}" if debug_mode
          if skip_update
            p "Skipping update (no change)" if debug_mode
            next           
          else 
            puts "Update Record Before: #{result.to_json}" 
            record = result.update_attributes(params)
            puts "Update Record After: #{params}"
            total_updates += 1
          end
          if (record) 
           if (args[:model] == "Faculty")
              record = Module.const_get(args[:model]).find_by_znumber(params["znumber"])
            else
              record = Module.const_get(args[:model]).find_by_name(params["name"])
            end
            puts "Update to New Record: #{record.to_json}" if debug_mode
          else  
            p "XXX : Update to New Record: Failed"
          end          
        else
          record = Module.const_get(args[:model]).create(params)
          puts "Create New Record: #{record.to_json}" #if debug_mode
        end
      else
        # Do more complicated ones here
        record = Module.const_get(args[:model]).create(params)
        total_inserts += 1
      end
      if (record.id == nil)
        puts "XXX: FAILED"
      end
    else
      puts "Skipping record: #{row}"
    end
  end
  puts "Total Rows: #{total_rows}  Total Inserts: #{total_inserts}   Total Updates: #{total_updates}"
end