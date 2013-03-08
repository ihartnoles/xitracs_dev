class Newhiresignoff < ActiveRecord::Base

	def role(user_id)

		user_group_id = User.find(user_id).group_id
		groupname = Group.find(user_group_id).name

		return groupname
	end

end
