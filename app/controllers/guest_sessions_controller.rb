class GuestSessionsController < ApplicationController
  def create
    @user = User.find_or_create_by(email: 'guest00@example.com') do |user|
      user.name = "ゲスト"
      user.password = SecureRandom.alphanumeric(10) + [*'a'..'z'].sample(1).join + [*'0'..'9'].sample(1).join
      user.activated = true
    end
    session[:user_id] = @user.id
    flash[:success] = 'ゲストユーザーとしてログインしました'
    redirect_to user_path(@user)
  end
end
