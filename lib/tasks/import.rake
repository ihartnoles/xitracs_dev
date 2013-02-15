# http://erikonrails.snowedin.net/?p=212

require 'csv'


desc 'Import CSV file into an Active Record table'
task :csv_model_import, [:filename, :model, :debug] => :environment do |task,args|
   firstline=0
   total_rows = 0
   total_inserts = 0
   keys = {}
   
   table_list = {"school"              => ["School", "name"],
              "department"          => ["Department", "name"],
              "course"              => ["Course", "name"],
              "section"             => ["Section", "name"],
              "faculty"             => ["Faculty", "znumber"],
              "qualification"       => ["Qualification", "name"],
              "qualificationaward"  => ["Qualificationaward", "name"]
            }
              
   
   debug_mode = args[:debug] == 'debug' ? true : false
   
   p table_list if debug_mode
   
   CSV.foreach(args[:filename], {col_sep: '|', quote_char: '%'}) do |row|
      p row if debug_mode
      if (firstline==0)
         keys = row
         firstline=1
         next
      end
      total_rows += 1

      params = {}
      skip_record = false
      keys.each_with_index do |key,i|
			  if (key.downcase.end_with?("_id")) then
          key_name = key.downcase.sub("_id","")
          p "key = #{key} key_name = #{key_name}" if debug_mode
          if (table_list[key_name] != nil) then
            p "Searching for #{table_list[key_name]} = #{row[i]}" if debug_mode
            row[i] = 'Unknown' if (key_name == 'qualification' && row[i] == nil) 
            row[i] = 'Unknown Degree' if (key_name == 'qualification_awardname' && row[i] == nil) 
            result = Module.const_get(table_list[key_name][0]).where(table_list[key_name][1] => row[i])
            if (result.count == 0) then    
              p row
              p "XXX : Unable to find record in [#{key_name}] for value [#{row[i]}]"    
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
        elsif 
          # p "Adding #{key.downcase} = #{row[i]}"
          params[key.downcase] = row[i]
        end
      end
      if (!skip_record) then
        p params
        record = Module.const_get(args[:model]).create(params)
        if (record.id == nil)
          puts "FAILED"
        else
          total_inserts += 1
        end
      end
    end
    puts "Total Rows: #{total_rows}  Total Inserts: #{total_inserts}"
end
