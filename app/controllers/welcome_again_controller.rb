class WelcomeAgainController < ApplicationController
  def index
    @new_items = Item.where('created_at > ?', current_user.last_sign_in_at)
  end
end

