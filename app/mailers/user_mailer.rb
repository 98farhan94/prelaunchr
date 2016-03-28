class UserMailer < ActionMailer::Base
    default from: "Joey <info@joeyapp.com>"

  def signup_email(user)
    @user = user
      @twitter_message = "Breastfeeding is evolving. Excited for @joey to launch."

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
