class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def downgrade
    @user = User.find(current_user.id)
    @user.downgrade
    redirect_to user_path(@user)
  end
end
