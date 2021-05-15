class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "【重要】Small Taskよりアカウント有効化のためのメールのお知らせ"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "【重要】Small Taskよりパスワード再設定のためのメールのお知らせ"
  end
end
