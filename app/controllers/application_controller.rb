class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  protect_from_forgery

  def authenticate_active_admin_user!
    authenticate_user!

    unless current_user.superadmin?
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path 
    end

  end


  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      edit_user_registration_path
    #elsif Item.where('created_at > ?', current_user.last_sign_in_at).count > 0
    #  news_path
    else
      root_path
    end

  end

end

