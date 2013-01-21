class UserMailer < ActionMailer::Base
  default from: "admin@geodocs.com.au"

  def new_items(user, new_items = nil)

    @user = user
    @items = new_items
    
    mail(:to => user.email, :subject => "New items in Geodocs")
    
  end
end
