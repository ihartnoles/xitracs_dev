require 'csv'

require "#{Rails.root}/app/helpers/application_helper"
include ApplicationHelper

#"XITRACS_FACULTY_CREDENTIALS.txt" => "FACULTY_ID|EMAIL|QUALIFICATIONAWARD_ID|QUALIFICATION_NAME|QUALIFICATION_INSTITUTION|QUALIFICATION_FIELD|QUALIFICATION_YEAR|TRANSCRIPT_ON_FILE|CIP_CODES",

desc 'Import CSV file into an Active Record table'

def print_fc(params)
  puts "#{params.id} : #{params.qualificationaward.name} - #{params.qualification_name} - #{params.qualification_institution} - #{params.qualification_field} - #{params.qualification_year}"        
end

def ask message
  print message
  STDIN.gets.chomp
end

task :update_facultycredentials, [:filename, :update, :debug] => :environment do |task,args| # XXX
  total_inserts = 0
  total_updates = 0
  total_skipped = 0
  total_nochange = 0

  update_mode = args[:update] == 'update' ? true : false  
  debug_mode = args[:debug] == 'debug' ? true : false

  total_rows = -1
  unknown_qualificationaward = 0
  blank_qualificationaward = 0
  unknown_faculty = 0
  all_records = Facultycredential.find(:all)  # XXX 
  print ncurses_bold
  puts "Total Existing Records: #{all_records.count}"
  print ncurses_sgr0
  
  CSV.foreach(args[:filename], {col_sep: '|', quote_char: '%'}) do |row|

    total_rows += 1
    next if (total_rows == 0)
    if (row[2] == nil || row[2].length == 0) # Skip blank entries
      total_skipped += 1
    end
    p row if debug_mode
    
    # XXX
    # row[10] = 'Unknown' if row[10] == nil
    # row[i] = 'Unknown Degree' if row[i] == nil
    
    # XXX
    params = {}
    params["faculty_id"] = ((d = Faculty.find_by_znumber(row[0])) != nil ? d.id : nil)
    params["email"] = row[1]
    params["qualificationaward_id"] = ((d = Qualificationaward.find_by_name(row[2])) != nil ? d.id : nil)
    params["qualification_name"] = row[3]
    params["qualification_institution"] = row[4]
    params["qualification_field"] = row[5]
    params["qualification_year"] = row[6]
    params["transcript_on_file"] = row[7]
    params["cip_codes"] = row[8]

    # XXX    
    if params["qualificationaward_id"] == nil 
      #puts "Unknown Qualification Award #{row[0]} #{row[1]} #{row[2]} #{row[3]}"
      unknown_qualificationaward += 1
      blank_qualificationaward += 1 if (row[2].nil? || row[2].length == 0) 
      next
    end
    if params["faculty_id"] == nil 
      puts "Unknown Faculty #{row[0]} #{row[1]} #{row[2]} #{row[3]}"
      unknown_faculty += 1
      next
    end
    p params if debug_mode
        
    if ((record_all = Facultycredential.where(:faculty_id =>            params["faculty_id"], 
                                          :qualificationaward_id =>     params["qualificationaward_id"], 
                                          :qualification_name =>        params["qualification_name"], 
                                          :qualification_institution => params["qualification_institution"], 
                                          :qualification_field =>       params["qualification_field"], 
                                          :qualification_year =>        params["qualification_year"] 
                                          )).count > 0)
      puts "XXX: Found muliple records for #{params}" if (record_all.count > 1)
      record = record_all[0]
      all_records.delete(record)
      did_update = false
      record.attributes.keys.each do |key|
        next if ["id", "created_at", "updated_at", "completed", "description"].index(key)
        if record[key].to_s != params[key].to_s
          p "Match Failed for #{key} : #{record[key].to_s} and #{params[key].to_s}" if debug_mode
          record.update_attributes(params)
          params["description"] = "" # Remove for cleaner printing
          puts "Update Record: #{params}" if debug_mode
          total_updates += 1
          did_update = true
          break
        end 
      end
      total_nochange += 1 if !did_update
    else
      if ((f = Facultycredential.create(params)) == nil) # XXX
        puts("XXX: Create Record Failed: #{params}")  
      else 
        #puts ("Create Record: #{params}")  if update_mode
        total_inserts += 1
      end
    end
  end
  
  puts "Total Rows: #{total_rows}  NoChange: #{total_nochange} Skipped: #{total_skipped} Inserts: #{total_inserts} Updates: #{total_updates} "
  puts "Unknown Qualificationaward: #{unknown_qualificationaward} (#{blank_qualificationaward} were empty)  Unknown Faculty #{unknown_faculty}"
  puts "Records to be Deleted: #{all_records.count}"
  
  # XXX    
  puts "Records Left Before Deletion: #{Facultycredential.find(:all).count}"

  all_records.each do |record|
    #puts "Deleting: #{record.to_json}"
    credits = Credit.where(:facultycredential_id => record.id)
    if (credits.count > 0)
      print "Deleting: "
      print ncurses_bold
      print_fc(record)
      print ncurses_sgr0      
      puts "\tDeleting Credential ID:#{record.id} will orphan #{credits.count} Course Credits." 
      last_id = record.id
      total_ids = 0
      Facultycredential.where(:faculty_id => record.faculty_id).each do |fc|  
       if (fc.id != record.id) 
          print "\t"
          print_fc(fc)
          last_id = fc.id # The last ID which we printed (used later as default ID if user hits enter)
          total_ids += 1
        end
      end
      user_action = ""
      if (total_ids == 1)
        puts "\tOnly one credential left: #{last_id}. Using it as default"
      else
        user_action = ask "\tSelect ID from above, <enter> to select last ID or 'del' to delete: "
      end
      if (user_action == "del")
        record.delete
      else
        params = {}
        if (user_action == "") # User hit <enter> or only one credential left
          source_record = Facultycredential.find(last_id)
          puts "\tUsing Credential ID #{last_id}"
        else
          source_record = Facultycredential.find(user_action.to_i)
        end
        params[:qualificationaward_id]      = source_record.qualificationaward_id 
        params[:qualification_name]         = source_record.qualification_name
        params[:qualification_institution]  = source_record.qualification_institution 
        params[:qualification_field]        = source_record.qualification_field
        params[:qualification_year]         = source_record.qualification_year 
        record.update_attributes(params)
        source_record.delete
      end  
      puts
    else
      record.delete
    end  
  end
  puts "Total Left After Deletion: #{Facultycredential.find(:all).count}"
end