class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "text.activated_msg"
      redirect_to user
    else
      flash[:danger] = t "text.fail_activated"
      redirect_to root_url
    end
  end
end
