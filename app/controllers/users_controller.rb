class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def index
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts.build
    @posts = Post.all.includes(:user).page(params[:page]).per(10)
    @tasks = @user.posts.all.includes(:user).where(complete: false).limit(3)
    @completed = @user.posts.all.includes(:user).where(complete: false)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = '認証用メールを送信しました。登録時のメールアドレスから認証を済ませてください'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールの更新に成功しました'
      redirect_to edit_user_path(@user)
    else
      flash.now[:danger] = 'プロフィールの編集に失敗しました'
      render 'edit'
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:warning] = 'ログインしてください'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to current_user unless current_user?(@user)
  end
end
