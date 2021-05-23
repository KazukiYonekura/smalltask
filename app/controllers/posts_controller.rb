class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :edit, :update, :destroy]
  before_action :correct_user, only: :destroy

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def create
    @user = current_user
    @post = current_user.posts.create!(post_params) if logged_in?
    @posts = @user.posts.page(params[:page]).per(10)

    if @post.save
      redirect_to current_user
    else
      render 'users/show'
    end
  end

  def edit
    @post = current_user.posts.find_by(id: params[:id]) || nil
    if @post.nil?
      flash[:warning] = '編集権限がありません'
      redirect_to user_path(current_user)
    end
  end

  def update
    @post = current_user.posts.find_by(id: params[:id]) || nil
    if @post.nil?
      flash[:warning] = '編集権限がありません'
      redirect_to user_path(current_user)
    elsif @post.update(post_params)
      flash[:success] = '編集が完了しました'
      redirect_to current_user
    else
      render 'posts/edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'ログが削除されました'
    redirect_to current_user
  end

  private

  def post_params
    params.require(:post).permit(:content, :text, :picture, :complete)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
