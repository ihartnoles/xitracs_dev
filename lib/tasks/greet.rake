task :greet do
   #puts "Hello world"

   #database_name = ActiveRecord::Base.connection.instance_variable_get("@config")[:database]
   client = Mysql2::Client.new(:host => "localhost", :username => "root", :database => "xitracs_dev", :password => "love13")
   #adapter = ActiveRecord::Base.connection.adapter_name.downcase

   #sql = "select FORMAT(SUM(data_length + index_length), 0) as bytes from information_schema.TABLES where table_schema = 'xitracs_dev'"
   #puts ActiveRecord::Base.connection.execute(sql).fetch_hash.values.first
   @output = client.query("select FORMAT(SUM(data_length + index_length), 0) as bytes from information_schema.TABLES where table_schema = 'xitracs_dev'")
   puts @output
end