class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t("users.controller.successful_save")
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email,
                                 :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t("not_found_user")
    redirect_to root_path
  end
end
