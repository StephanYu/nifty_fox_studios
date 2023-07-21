class UsersController < ApplicationController
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update]
  before_action :require_admin, only: [:destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Account created successfully!"
    else
      render :new, status: :unprocessable_entity, alert: "Account creation failed!"
    end
  end

  def edit
  end

  def update
    if @user.update!(user_params)
      redirect_to user_path(@user), notice: "Account updated successfully!"
    else
      render :edit, status: :unprocessable_entity, alert: "Account update failed!"
    end
  end

  def delete
    if @user.destroy
      session[:user_id] = nil
      redirect_to movies_url, status: :see_other, alert: "Account successfully deleted!"
    else
      render :show, status: :unprocessable_entity, alert: "Account deletion failed!"
    end
  end

  private

  def user_params
    params.require(:user).
      permit(:name, :email, :password, :password_confirmation)
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
