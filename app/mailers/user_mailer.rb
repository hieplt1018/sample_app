class UserMailer < ApplicationMailer
  def account_activation
    @greeting = t "text.hi"

    mail to: "to@example.org"
  end

  def account_activation user
    @user = user
    mail to: user.email, subject: t("titles.email_title")
  end

  def password_reset user
    @user = user
    mail to: user.email, subject: t("titles.email_reset_title")
  end
end
