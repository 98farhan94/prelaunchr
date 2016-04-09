class UserMailer < ActionMailer::Base
  default from: "Prajakta <prajakta@thejoeyapp.com>"

  def signup_email(user)
    @user = user
      @twitter_message = "Breastfeeding is evolving. Excited for @joey to launch."

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
