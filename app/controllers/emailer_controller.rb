class EmailerController < ApplicationController
  def email_send
    
    items = Item.where("created_at >= ?", Time.now.beginning_of_day)

    User.all.each do |u|
      UserMailer.new_items(u, items).deliver
    end
    
    flash[:success] = "Emails are successfully sent!"

    redirect_to admin_dashboard_path  

  end
end

