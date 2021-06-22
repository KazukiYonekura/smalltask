class ProfileController < ApplicationController
  def show
    @user = User.find(params[:id])
    @current = current_user
  end
end
