class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def downgrade
    @user = User.find(current_user.id)
    flash[:alert] =  "You've been downgraded to a Standard user and all of your wikis are public!"
    @user.downgrade
    redirect_to user_path(@user)
  end
end
