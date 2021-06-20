class TasksController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all.includes(:user).page(params[:page]).per(10)
  end
end
