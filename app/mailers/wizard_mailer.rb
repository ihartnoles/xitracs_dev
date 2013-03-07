class WizardMailer < ActionMailer::Base
  default from: "ihartstein@fau.edu"
  
  def new_user_email(user)
    @user = user
    mail(:from => "#{@user.name}@fau.edu", :to => 'ihartstein@fau.edu', :subject => "New SACS User Request: #{@user.name}")
  end
  
  def login_failed_email(username)
    @username = username
    mail(:from => '#{@username}@fau.edu', :to => 'ihartstein@fau.edu', :subject => "Failed Login: #{@username}")
  end

  def send_review_msg(newhire, msg)
  	@newhire = newhire
    @msg = msg

    #TO DO: make TO and FROM dynamic to come from form
    mail(:from => "#ihartstein@fau.edu", :to => 'ihartstein@fau.edu', :subject => "Test Notification")
  end

end
