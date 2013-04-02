class WizardMailer < ActionMailer::Base
  default from: "ihartstein@fau.edu"
  
  def new_user_email(user)
    @user = user
    mail(:from => "#{@user.name}@fau.edu", :to => 'ihartstein@fau.edu', :subject => "New SACS User Request: #{@user.name}")
  end
  
  def login_failed_email(username)
    @username = username
    mail(:from => "#{@username}@fau.edu", :to => 'ihartstein@fau.edu', :subject => "Failed Login: #{@username}")
  end

  def send_msg(newhire,subject,msg,sendto,body,sentby)
  	@newhire = newhire
    @subject = subject
    @msg = msg
    @sendto = sendto
    @bodymsg = body
    @sentby = sentby   

    #TO DO: make TO and FROM dynamic to come from form
    mail(:from => "#{@sentby}@fau.edu", :to => "#{@sendto}@fau.edu", :subject => "#{@subject}")
  end

end
