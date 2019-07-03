class UsersController < ApplicationController
  def show
    @user = User.find_by params[:id]
    return if @user
    flash[:error] = t("error_page.error_message")
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t("error_page.succeed_message")
      redirect_to @user
    else
      render :new
    end
  end
  private
    def user_params
      params.require(:user).permit :name, :email, :password,
        :password_confirmation
    end
end
