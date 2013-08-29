class ShareMailer < ActionMailer::Base

  def share_with_email(user, email, webshot)

  	@user = user
  	@webshot = webshot

  	mail(:to => email, :subject => "#{user.profile.nickname} shared a webshot to you.", :from => user.email)

  end
end
