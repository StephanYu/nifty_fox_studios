class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to (session[:prev_requested_url] || movies_path), notice: "Welcome back, #{@user.name}!"
      session[:prev_requested_url] = nil
    else
      flash.now[:alert] = "Invalid email/password combination!"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, status: :see_other, notice: "You're now signed out!"
  end
end
