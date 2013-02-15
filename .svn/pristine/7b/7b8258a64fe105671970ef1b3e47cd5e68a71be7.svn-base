class WizardMailer < ActionMailer::Base
  default from: "mahesh@fau.edu"
  
  def new_user_email(user)
    @user = user
    mail(:from => "#{@user.name}@fau.edu", :to => 'mahesh@fau.edu', :subject => "New SACS User Request: #{@user.name}")
  end
  
  def login_failed_email(username)
    @username = username
    mail(:from => '#{@username}@fau.edu', :to => 'mahesh@fau.edu', :subject => "Failed Login: #{@username}")
  end
end
