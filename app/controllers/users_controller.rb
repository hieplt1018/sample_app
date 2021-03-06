class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: %i(destroy)
  before_action :load_user, except: %i(index new create)

  def index
    @users = User.order(:name).page(params[:page]).per(Settings.accountPerPage)
  end

  def show
    @microposts = Micropost.order(:name).page(params[:page]).per Settings.accountPerPage
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "text.require_activate"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "error_page.edit_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "error_page.delete_success"
    else
      flash[:danger] = t "error_page.delete_fail"
    end
    redirect_to users_url
  end

  def following
    @title = t "tittles.following_title"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page])
    render "show_follow"
  end

  def followers
    @title = t "tittles.followers_title"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page])
    render "show_follow"
  end

  private
    def user_params
      params.require(:user).permit :name, :email, :password,
        :password_confirmation
    end

    def correct_user
      redirect_to root_url unless current_user? @user
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

    def load_user
      @user = User.find_by id: params[:id]
      return if @user
      flash[:error] = t("error_page.error_message")
      redirect_to root_path
    end
end
