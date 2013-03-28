class Newhiresignoff < ActiveRecord::Base
	
	def signed_off_by(user_id)
		user = User.find(user_id)
		username = user.name.humanize

		#usertype = Group.find(user.group_id).name.humanize

		#return "#{username} - <i>#{usertype}</i>".html_safe
		return "#{username}"
	end

	def status(val,user_type,final_approval)

	 	case user_type           
            when  1 then display = 'Admin/Provost'
            when  2 then display = 'Dean'
            when  3 then display = 'Chair'           
        end 

        if final_approval == 1
        	  status = "Final Approval"
       	else
       		if val == 1 
       			status = "Approved by #{display}"
       		else
       			status = "Returned by #{display}"
       		end
        end

		return status
	end

end
