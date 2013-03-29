class Newhirecourse < ActiveRecord::Base
	has_many :newhireinstitutions
	belongs_to :newhire

	def reviewed_by_reviewteam(course_id)

		status = Newhirereviewreason.find_by_sql(['select distinct t1.reviewer_id
                                                          from newhirereviewreasons t1, newhirereviewreasons t2
                                                          where t1.course_id = t2.course_id
                                                          and t1.course_id = :cid
                                                          and t1.review_state = 1;' ,{:cid => course_id}]) 

		return status
	end


	def signed_off_by_provost(course_id, newhire_id)

		#status = Newhirereviewreason.where(:newhire_id => newhire_id , :course_id =>  course_id, :review_state => "1").count

		signedoff = Newhiresignoff.find_by_sql(['select id from newhiresignoffs where signed_off=1 and course_id = :cid and newhire_id=:nid and user_id IN (13,14,15,16,18,19,20,21,22,25,76,84,85,96,98,99,109,111,112)' ,{:cid => course_id, :nid => newhire_id }]) 

		return signedoff.count
	end
end
