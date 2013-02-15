class StaticPagesController < ApplicationController
  
  def register
		@user = nil
    if (!params[:fauid].nil? && params[:fauid].length > 0) 
      if (params[:status] == 'chair')
        department_id = params[:department]
        school_id = Department.find(department_id).school.id
      else
        school_id = params[:school]
        department_id = Department.where(:school_id => school_id).first.id
      end  
      group_id = Group.find_by_name(params[:status]).id
      @user = User.new(:name => params[:fauid], :school_id => school_id, :department_id => department_id, :group_id => group_id)
      WizardMailer.new_user_email(@user).deliver
    end
  end

  def start
    session.delete(:search_mode)
  end
end
